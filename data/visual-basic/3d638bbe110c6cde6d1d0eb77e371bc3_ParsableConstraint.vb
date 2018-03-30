'
'	component:   "openEHR Archetype Project"
'	description: "Constraints on URI values"
'	keywords:    "Archetype, Clinical, Editor"
'	author:      "Sam Heard"
'	support:     http://www.openehr.org/issues/browse/AEPR
'	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
'	license:     "See notice at bottom of class"
'
'	file:        "$URL: http://www.openehr.org/svn/knowledge_tools_dotnet/TRUNK/ArchetypeEditor/DataConstraints/UriConstraint.vb $"
'	revision:    "$LastChangedRevision: 140 $"
'	last_change: "$LastChangedDate: 2007-08-04 10:00:56 +0200 (Sat, 04 Aug 2007) $"
'

Option Strict On

Public Class Constraint_Parsable
    Inherits Constraint

    Dim mFormalism As New Generic.List(Of String)

    Public Overrides Function Copy() As Constraint
        Dim result As New Constraint_Parsable
        result.mFormalism = mFormalism
        Return result
    End Function

    Public Overrides ReadOnly Property Kind() As ConstraintKind
        Get
            Return ConstraintKind.Parsable
        End Get
    End Property

    Public Property AllowableFormalisms() As Generic.List(Of String)
        Get
            Return mFormalism
        End Get
        Set(ByVal Value As Generic.List(Of String))
            mFormalism = Value
        End Set
    End Property

    'Dim mRegex As String

    'Public Property RegularExpression() As String
    '    Get
    '        Return mRegex
    '    End Get
    '    Set(ByVal value As String)
    '        mRegex = value
    '    End Set
    'End Property

End Class

'
'***** BEGIN LICENSE BLOCK *****
'Version: MPL 1.1/GPL 2.0/LGPL 2.1
'
'The contents of this file are subject to the Mozilla Public License Version 
'1.1 (the "License"); you may not use this file except in compliance with 
'the License. You may obtain a copy of the License at 
'http://www.mozilla.org/MPL/
'
'Software distributed under the License is distributed on an "AS IS" basis,
'WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
'for the specific language governing rights and limitations under the
'License.
'
'The Original Code is UriConstraint.vb.
'
'The Initial Developer of the Original Code is
'Sam Heard, Ocean Informatics (www.oceaninformatics.biz).
'Portions created by the Initial Developer are Copyright (C) 2004
'the Initial Developer. All Rights Reserved.
'
'Contributor(s):
'	Heath Frankel
'
'Alternatively, the contents of this file may be used under the terms of
'either the GNU General Public License Version 2 or later (the "GPL"), or
'the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
'in which case the provisions of the GPL or the LGPL are applicable instead
'of those above. If you wish to allow use of your version of this file only
'under the terms of either the GPL or the LGPL, and not to allow others to
'use your version of this file under the terms of the MPL, indicate your
'decision by deleting the provisions above and replace them with the notice
'and other provisions required by the GPL or the LGPL. If you do not delete
'the provisions above, a recipient may use your version of this file under
'the terms of any one of the MPL, the GPL or the LGPL.
'
'***** END LICENSE BLOCK *****
'