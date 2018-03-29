// $begin{copyright}
//
// This file is part of WebSharper
//
// Copyright (c) 2008-2014 IntelliFactory
//
// Licensed under the Apache License, Version 2.0 (the "License"); you
// may not use this file except in compliance with the License.  You may
// obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
// implied.  See the License for the specific language governing
// permissions and limitations under the License.
//
// $end{copyright}

module IntelliFactory.WebSharper.Core.Quotations

module R = IntelliFactory.WebSharper.Core.Reflection

type AssemblyName = System.Reflection.AssemblyName
type BitConverter = System.BitConverter
type Dictionary<'T1,'T2> = System.Collections.Generic.Dictionary<'T1,'T2>
type Encoding = System.Text.Encoding
type Name = string
type Path = string
type Stream = System.IO.Stream

exception UnreachableException
exception InvalidFormatException

type Input =
    {
        mutable Buffer : byte []
        Stream : Stream
        SymbolTable : string []
    }

type Definition =
    | ConstructorDefinition of R.Constructor
    | MethodDefinition of R.Method
    | PropertyDefinition of R.Property

    override this.ToString() =
        match this with
        | ConstructorDefinition x -> string x
        | MethodDefinition x -> string x
        | PropertyDefinition x -> string x

module Ids =
    let root = obj ()
    let mutable k = 0
    let next () = lock root (fun () -> k <- k + 1; k)
    let globals = Dictionary<_,obj>()

[<CustomComparison>]
[<CustomEquality>]
type Id =
    {
        id : int
        name : string
        ty : R.Type
        mut : bool
    }

    static member Create name ty =
        {
            id = Ids.next()
            name = name
            ty = ty
            mut = false
        }

    static member CreateMutable name ty =
        {
            id = Ids.next()
            name = name
            ty = ty
            mut = true
        }

    member this.Name = this.name
    member this.Type = this.ty
    member this.Mutable = this.mut
    member private this.Id = this.id
    override this.GetHashCode() = this.id

    override this.ToString() =
        System.String.Format("{0}#{1}", this.name, this.id)

    static member Global name ty =
        let key = (name, ty)
        match Ids.globals.TryGetValue key with
        | true, v -> v :?> Id
        | _ ->
            let v = Id.Create name ty
            Ids.globals.[key] <- v
            v

    override this.Equals other =
        match other with
        | :? Id as o -> this.id = o.Id
        | _ -> false

    interface System.IComparable with
        member this.CompareTo other =
            match other with
            | :? Id as o -> compare this.id o.Id
            | _ -> invalidArg "other" "Invalid comparison."

type Concrete<'T> =
    {
        Entity : 'T
        Generics : list<R.Type>
    }

    override this.ToString() =
        string (box this.Entity)

let (|Concrete|) {Entity = e; Generics = gs} =
    Concrete (e, gs)

let Concrete (e, gs) =
    {Entity = e; Generics = gs}

type Literal =
    | Bool of bool
    | Byte of byte
    | Char of char
    | Double of double
    | Int of int
    | Int16 of int16
    | Int64 of int64
    | SByte of sbyte
    | Single of single
    | String of string
    | Unit
    | UInt16 of uint16
    | UInt32 of uint32
    | UInt64 of uint64

type Expression =
    | AddressOf of E
    | AddressSet of E * E
    | Application of E * E
    | Call of Concrete<R.Method> * list<E>
    | CallModule of Concrete<R.Method> * list<E>
    | Coerce of R.Type * E
    | DefaultValue of R.Type
    | FieldGetInstance of E * Concrete<R.Field>
    | FieldGetRecord of E * Concrete<R.Property>
    | FieldGetStatic of Concrete<R.Field>
    | FieldGetUnion of E * Concrete<R.UnionCase> * int
    | FieldSetRecord of E * Concrete<R.Property> * E
    | FieldSetInstance of E * Concrete<R.Field> * E
    | FieldSetStatic of Concrete<R.Field> * E
    | ForIntegerRangeLoop of Id * E * E * E
    | Hole of R.Type * int
    | IfThenElse of E * E * E
    | Lambda of Id * E
    | Let of Id * E * E
    | LetRecursive of list<Id * E> * E
    | NewArray of R.Type * list<E>
    | NewDelegate of R.Type * E
    | NewObject of Concrete<R.Constructor> * list<E>
    | NewRecord of R.Type * list<E>
    | NewTuple of list<E>
    | NewUnionCase of Concrete<R.UnionCase> * list<E>
    | PropertyGet of Concrete<R.Property> * list<E>
    | PropertySet of Concrete<R.Property> * list<E>
    | Quote of E
    | Sequential of E * E
    | TupleGet of int * E
    | TryFinally of E * E
    | TryWith of E * Id * E * Id * E
    | TypeTest of R.Type * E
    | UnionCaseTest of Concrete<R.UnionCase> * E
    | Value of Literal
    | Var of Id
    | VarSet of Id * E
    | WhileLoop of E * E

and private E = Expression

type Definitions =
    list<Definition * Expression>

module Environment =

    type Record =
        private {
            vars : Map<int,Id>
            count : int
        }

    let Create () =
        {
            vars = Map.empty
            count = 0
        }

    let WithVar var env =
        let k = env.count
        {
            count = k + 1
            vars = Map.add k var env.vars
        }

    let ResolveVar index env =
        env.vars.[index]

let inline ReadByte (input: Input) =
    input.Stream.ReadByte()

let ReadInt (input: Input) =
    let b0 = ReadByte input
    if b0 <= 0x7F then
        b0
    elif b0 <= 0xbf then
        let b0 = b0 &&& 0x7f
        let b1 = ReadByte input
        (b0 <<< 8) ||| b1
    else
        let b0 = ReadByte input
        let b1 = ReadByte input
        let b2 = ReadByte input
        let b3 = ReadByte input
        b0 ||| (b1 <<< 8) ||| (b2 <<< 16) ||| (b3 <<< 24)

let ReadSignedByte input =
    sbyte (ReadInt input)

let ReadUnsignedByte input =
    byte (ReadByte input)

let ReadShort input =
    int16 (ReadInt input)

let ReadUnsignedShort input =
    uint16 (ReadInt input)

let ReadUnsignedInt input =
    uint32 (ReadInt input)

let ReadLong input =
    let b1 = int64 (ReadInt input) &&& 0xFFFFFFFFL
    let b2 = int64 (ReadInt input)
    b1 ||| (b2 <<< 32)

let ReadChar input =
    char (ReadInt input)

let ReadDouble input =
    BitConverter.ToDouble(BitConverter.GetBytes(ReadLong input), 0)

let ReadSingle input =
    BitConverter.ToSingle(BitConverter.GetBytes(ReadInt input), 0)

let ReadUnsignedLong input =
    uint64 (ReadLong input)

let ReadText (input: Input) =
    let k = ReadInt input
    if input.Buffer.Length < k then
        System.Array.Resize(&input.Buffer, k)
    if input.Stream.Read(input.Buffer, 0, k) <> k then
        raise InvalidFormatException
    Encoding.UTF8.GetString(input.Buffer, 0, k)

let ReadString (input: Input) =
    let n = ReadInt input
    if n < 0 || n >= input.SymbolTable.Length then
        raise InvalidFormatException
    input.SymbolTable.[n]

let ReadArray read input =
    let q = System.Collections.Generic.Queue(32)
    while ReadByte input > 0 do
        q.Enqueue (read input)
    q.ToArray()

let ReadList read input =
    let rec loop acc =
        match ReadByte input with
        | 0 -> List.rev acc
        | _ -> loop (read input :: acc)
    loop []

let ReadList0 input =
    match ReadInt input with
    | 0 -> ()
    | _ -> raise InvalidFormatException

let ReadList1 read input =
    match ReadList read input with
    | [a] -> a
    | _ -> raise InvalidFormatException

let ReadList2 read input =
    match ReadList read input with
    | [a; b] -> (a, b)
    | _ -> raise InvalidFormatException

let ReadList3 read input =
    match ReadList read input with
    | [a; b; c] -> (a, b, c)
    | _ -> raise InvalidFormatException

let ReadBytes input =
    let k = ReadInt input
    if input.Buffer.Length < k then
        System.Array.Resize(&input.Buffer, k)
    if input.Stream.Read(input.Buffer, 0, k) <> k then
        raise InvalidFormatException
    input.Buffer.[0 .. k - 1]

let ReadObject read input =
    let strings = ReadArray ReadText input
    let count = ReadInt input
    read {
        Buffer = input.Buffer
        SymbolTable = strings
        Stream = input.Stream
    }

let ReadBool input =
    ReadByte input = 1

let ReadStream (assemblyName: AssemblyName) (stream: System.IO.Stream) =
    let localAssembly = assemblyName.FullName
    let readAssemblyReference input =
        match ReadString input with
        | "" -> typeof<int>.Assembly.FullName
        | "." -> localAssembly
        | s -> s
    let readTypeReference (input: Input) =
        let n = ReadString input
        let a = readAssemblyReference input
        R.TypeDefinition.Parse(System.String.Format("{0}, {1}", n, a))
    let readModuleDefinition (input: Input) =
        let ty = readTypeReference input
        let name = ReadString input
        let isProp = ReadBool input
        if isProp then
            R.Property.CreateReference ty name
            |> PropertyDefinition
        else
            R.Method.CreateReference ty name
            |> MethodDefinition
    let rec readType input =
        match ReadByte input with
        | 0 -> R.Type.Generic (ReadInt input)
        | 1 ->
            match ReadByte input with
            | 1 ->
                let (d, r) = ReadList2 readType input
                R.Type.Concrete (
                    R.TypeDefinition.FromType typedefof<_->_>,
                    [d; r]
                )
            | 2 ->
                R.Type.Concrete (
                    readTypeReference input,
                    ReadList readType input
                )
            | 3 ->
                let k = ReadInt input
                let t = ReadList1 readType input
                R.Type.Array (t, k)
            | _ -> raise InvalidFormatException
        | _ -> raise InvalidFormatException
    let readValue v input =
        ignore (ReadList1 readType input)
        ReadList0 input
        Value v
    let readMethodReference input =
        let d = readTypeReference input
        let p = ReadList readType input
        let r = readType input
        let n = ReadString input
        let g = ReadInt input
        R.Method.Create d n g p r
    let readPropertyReference input =
        let d = readTypeReference input
        let n = ReadString input
        let t = readType input
        let i = ReadList readType input
        R.Property.Create d n t i
    let readConstructorReference input =
        let d = readTypeReference input
        let p = ReadList readType input
        R.Constructor.Create d p
    let readDefinition input =
        match ReadByte input with
        | 0 -> readModuleDefinition input
        | 1 -> MethodDefinition (readMethodReference input)
        | 2 -> ConstructorDefinition (readConstructorReference input)
        | _ -> raise InvalidFormatException
    let rec readExpression env input =
        let E = readExpression env
        match ReadByte input with
        | 0 -> readTerm env input
        | 1 -> Var (Environment.ResolveVar (ReadInt input) env)
        | 2 -> readLambda env input
        | 3 -> Hole (readType input, ReadInt input)
        | 4 -> Quote (E input)
        | 5 -> let (e, _) = (E input, ReadList E input) in e
        | 6 -> Var (Id.Global "this" (readType input))
        | _ -> raise InvalidFormatException
    and readTerm env input =
        let E = readExpression env
        match ReadByte input with
        | 0 ->
            ReadList0 input
            let (a, b, c) = ReadList3 E input
            IfThenElse (a, b, c)
        | 1 ->
            let mD = readModuleDefinition input
            let tA = ReadList readType input
            let args = ReadList E input
            match mD with
            | MethodDefinition m ->
                CallModule (Concrete (m, tA), args)
            | PropertyDefinition p ->
                PropertyGet (Concrete (p, []), [])
            | _ ->
                raise UnreachableException
        | 2 ->
            ReadList0 input
            ReadList1 (readLetRecursive env) input
        | 3 ->
            let t =
                R.Type.Concrete (
                    readTypeReference input,
                    ReadList readType input
                )
            NewRecord (t, ReadList E input)
        | 4 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let e = ReadList1 E input
            let p = R.Property.CreateReference t n
            FieldGetRecord (e, Concrete (p, a))
        | 5 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let e = ReadList E input
            let u = R.UnionCase.Create t n
            NewUnionCase (Concrete (u, a), e)
        | 6 ->
            let t = readTypeReference input
            let n = ReadString input
            let k = ReadInt input
            let a = ReadList readType input
            let e = ReadList1 E input
            let u = R.UnionCase.Create t n
            FieldGetUnion (e, Concrete (u, a), k)
        | 7 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let e = ReadList1 E input
            let u = R.UnionCase.Create t n
            UnionCaseTest (Concrete (u, a), e)
        | 8 ->
            let t = ReadList1 readType input
            NewTuple (ReadList E input)
        | 9 ->
            let k = ReadInt input
            let t = ReadList1 readType input
            TupleGet (k, ReadList1 E input)
        | 11 -> readValue (Bool (ReadBool input)) input
        | 12 -> readValue (String (ReadString input)) input
        | 13 -> readValue (Single (ReadSingle input)) input
        | 14 -> readValue (Double (ReadDouble input)) input
        | 15 -> readValue (Char (ReadChar input)) input
        | 16 -> readValue (SByte (ReadSignedByte input)) input
        | 17 -> readValue (Byte (ReadUnsignedByte input)) input
        | 18 -> readValue (Int16 (ReadShort input)) input
        | 19 -> readValue (UInt16 (ReadUnsignedShort input)) input
        | 20 -> readValue (Int (ReadInt input)) input
        | 21 -> readValue (UInt32 (ReadUnsignedInt input)) input
        | 22 -> readValue (Int64 (ReadLong input)) input
        | 23 -> readValue (UInt64 (ReadUnsignedLong input)) input
        | 24 ->
            ReadList0 input
            ReadList0 input
            Value Unit
        | 25 ->
            let pR = readPropertyReference input
            let prop = Concrete (pR, ReadList readType input)
            PropertyGet (prop, ReadList E input)
        | 26 ->
            let cR = readConstructorReference input
            let ctor = Concrete (cR, ReadList readType input)
            NewObject (ctor, ReadList E input)
        | 28 ->
            let t = ReadList1 readType input
            Coerce (t, ReadList1 E input)
        | 29 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            Sequential (a, b)
        | 30 ->
            ReadList0 input
            let (a, b, c) = ReadList3 E input
            match c with
            | Lambda (v, body) -> ForIntegerRangeLoop (v, a, b, body)
            | _ -> raise InvalidFormatException
        | 31 ->
            let mR = readMethodReference input
            let meth = Concrete (mR, ReadList readType input)
            Call (meth, ReadList E input)
        | 32 ->
            let t = ReadList1 readType input
            NewArray (t, ReadList E input)
        | 33 ->
            let t = ReadList1 readType input
            NewDelegate (t, ReadList1 E input)
        | 34 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            WhileLoop (a, b)
        | 35 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            match b with
            | Lambda (v, b) -> Let (v, a, b)
            | _ -> raise InvalidFormatException
        | 36 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let f = Concrete (R.Property.CreateReference t n, a)
            let (x, y) = ReadList2 E input
            FieldSetRecord (x, f, y)
        | 37 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let f = Concrete (R.Field.Create t n, a)
            match ReadList E input with
            | [] -> FieldGetStatic f
            | [x] -> FieldGetInstance (x, f)
            | _ -> raise InvalidFormatException
        | 39 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            Application (a, b)
        | 40 ->
            let t = ReadList1 readType input
            ReadList0 input
            Value Unit
        | 41 ->
            let t = ReadList1 readType input
            ReadList0 input
            DefaultValue t
        | 42 ->
            let pR = readPropertyReference input
            let a = ReadList readType input
            PropertySet (Concrete (pR, a), ReadList E input)
        | 43 ->
            let t = readTypeReference input
            let n = ReadString input
            let a = ReadList readType input
            let f = Concrete (R.Field.Create t n, a)
            match ReadList E input with
            | [x] -> FieldSetStatic (f, x)
            | [x; y] -> FieldSetInstance (x, f, y)
            | _ -> raise InvalidFormatException
        | 44 ->
            ReadList0 input
            AddressOf (ReadList1 E input)
        | 45 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            AddressSet (a, b)
        | 46 ->
            let t = ReadList1 readType input
            TypeTest (t, ReadList1 E input)
        | 47 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            TryFinally (a, b)
        | 48 ->
            ReadList0 input
            let (a, b, c) = ReadList3 E input
            match b, c with
            | Lambda (bV, bB), Lambda (cV, cB) -> TryWith (a, bV, bB, cV, cB)
            | _ -> raise InvalidFormatException
        | 49 ->
            ReadList0 input
            let (a, b) = ReadList2 E input
            match a with
            | Var x -> VarSet (x, b)
            | _ -> raise InvalidFormatException
        | _ ->
            raise InvalidFormatException
    and readLambda env input =
        let v = readVar input
        let b = readExpression (Environment.WithVar v env) input
        Lambda (v, b)
    and readLetRecursive env input =
        let rec loop env =
            match ReadInt input with
            | 0 -> // CombTerm
                match ReadInt input with
                | 38 -> // LetRecCombOp
                    ReadList0 input
                    match ReadList (readExpression env) input with
                    | b :: bs -> ([], bs, b)
                    | _ -> raise InvalidFormatException
                | _ ->
                    raise InvalidFormatException
            | 2 -> // LambdaTerm
                let v = readVar input
                let (vs, bs, b) = loop (Environment.WithVar v env)
                (v :: vs, bs, b)
            | _ ->
                raise InvalidFormatException
        let (vs, bs, b) = loop env
        LetRecursive (List.zip vs bs, b)
    and readVar input =
        let n = ReadString input
        let t = readType input
        let m = ReadBool input
        if m then Id.CreateMutable n t else Id.Create n t
    let readReflectedDefinition env input =
        (readDefinition input, readExpression env input)
    let env = Environment.Create()
    let input =
        {
            Buffer = Array.create 2048 (byte 0)
            Stream = stream
            SymbolTable = [||]
        }
    ReadObject (ReadList (readReflectedDefinition env)) input

let ReadAssembly (assembly: System.Reflection.Assembly) =
    assembly.GetManifestResourceNames()
    |> Seq.tryPick (fun x ->
        if x.ToUpper().StartsWith ("REFLECTED" + "DEFINITIONS") then
            use s = assembly.GetManifestResourceStream x
            Some (ReadStream (assembly.GetName()) s)
        else
            None)

let ReadAssemblyFile (file: string) =
    ReadAssembly (System.Reflection.Assembly.ReflectionOnlyLoadFrom file)

exception TransformException

let Transform (!) (expr: E) : E =
    let (!!) = List.map (!)
    let t v x =
        match !(Lambda (v, x)) with
        | Lambda (v, x) -> (v, x)
        | _ -> raise TransformException
    match expr with
    | AddressOf x ->
        AddressOf !x
    | AddressSet (x, y) ->
        AddressSet (!x, !y)
    | Application (x, y) ->
        Application (!x, !y)
    | Call (x, xs) ->
        Call (x, !!xs)
    | CallModule (x, xs) ->
        CallModule (x, !!xs)
    | Coerce (x, y) ->
        Coerce (x, !y)
    | DefaultValue _ ->
        expr
    | FieldGetInstance (x, y) ->
        FieldGetInstance (!x, y)
    | FieldGetRecord (x, y) ->
        FieldGetRecord (!x, y)
    | FieldGetStatic _ ->
        expr
    | FieldGetUnion (x, y, z) ->
        FieldGetUnion (!x, y, z)
    | FieldSetInstance (x, y, z) ->
        FieldSetInstance (!x, y, !z)
    | FieldSetRecord (x, y, z) ->
        FieldSetRecord (!x, y, !z)
    | FieldSetStatic (x, y) ->
        FieldSetStatic (x, !y)
    | ForIntegerRangeLoop (v, x, y, z) ->
        let x = !x
        let y = !y
        let (v, z) = t v z
        ForIntegerRangeLoop (v, x, y, z)
    | Hole _ ->
        expr
    | IfThenElse (x, y, z) ->
        IfThenElse (!x, !y, !z)
    | Lambda (x, y) ->
        Lambda (x, !y)
    | Let (v, x, y) ->
        let x = !x
        let (v, y) = t v y
        Let (v, x, y)
    | LetRecursive (vs, b) ->
        LetRecursive ([for (v, e) in vs -> (v, !e)], !b)
    | NewArray (x, xs) ->
        NewArray (x, !!xs)
    | NewDelegate (x, y) ->
        NewDelegate (x, !y)
    | NewObject (x, xs) ->
        NewObject (x, !!xs)
    | NewRecord (x, xs) ->
        NewRecord (x, !!xs)
    | NewTuple xs ->
        NewTuple !!xs
    | NewUnionCase (x, xs) ->
        NewUnionCase (x, !!xs)
    | PropertyGet (x, xs) ->
        PropertyGet (x, !!xs)
    | PropertySet (x, xs) ->
        PropertySet (x, !!xs)
    | Quote x ->
        Quote !x
    | Sequential (x, y) ->
        Sequential (!x, !y)
    | TryWith (x, v1, y1, v2, y2) ->
        let x = !x
        let (v1, y1) = t v1 y1
        let (v2, y2) = t v2 y2
        TryWith (x, v1, y1, v2, y2)
    | TryFinally (x, y) ->
        TryFinally (!x, !y)
    | TupleGet (y, z) ->
        TupleGet (y, !z)
    | TypeTest (x, y) ->
        TypeTest (x, !y)
    | UnionCaseTest (x, y) ->
        UnionCaseTest (x, !y)
    | Value _ ->
        expr
    | Var _ ->
        expr
    | VarSet (x, y) ->
        VarSet (x, !y)
    | WhileLoop (x, y) ->
        WhileLoop (!x, !y)

let Fold f init expr =
    let state = ref init
    let g x = state := f !state x; x
    ignore (Transform g expr)
    !state

let Alpha expr =
    let copy (id: Id) =
        if id.Mutable then
            Id.CreateMutable id.Name id.Type
        else
            Id.Create id.Name id.Type
    let rec t env expr =
        match expr with
        | Lambda (var, body) ->
            let v = copy var
            Lambda (v, t (Map.add var v env) body)
        | Let (var, value, body) ->
            let v = copy var
            Let (v, t env value, t (Map.add var v env) body)
        | LetRecursive (vars, body) ->
            let vs = List.map (fun (v, _) -> copy v) vars
            let env = List.fold2 (fun m (x, _) v -> Map.add x v m) env vars vs
            let vars = List.map2 (fun (_, b) v -> (v, t env b)) vars vs
            LetRecursive (vars, t env body)
        | Var id ->
            match env.TryFind id with
            | Some id -> Var id
            | None -> expr
        | VarSet (id, e) ->
            let id =
                match env.TryFind id with
                | Some id -> id
                | None -> id
            VarSet (id, t env e)
        | _ ->
            Transform (t env) expr
    t Map.empty expr

