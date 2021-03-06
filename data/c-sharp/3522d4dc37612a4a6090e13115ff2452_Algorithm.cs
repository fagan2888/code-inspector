
using System;
using System.Collections;
using System.Collections.Generic;

namespace Mistral.Utils
{
	public static class Algorithm
	{
		#region Fields

		private static Random random = new Random( DateTime.Now.Millisecond );

		#endregion

		#region Shuffle

		/// <summary>
		/// ????????????? ?????? ? ???????????? ???????
		/// </summary>
		public static void Shuffle( IList list )
		{
			for( int i = 0; i < list.Count; i++ )
			{
				int i1 = random.Next( 0, list.Count-1 );
				int i2 = random.Next( 0, list.Count-1 );
				Swap( list, i1, i2 );
			}
		}

		/// <summary>
		/// ????????????? ?????? ? ???????????? ???????
		/// </summary>
		public static void Shuffle<T>( IList<T> list )
		{
			for( int i = 0; i < list.Count; i++ )
			{
				int i1 = random.Next( 0, list.Count-1 );
				int i2 = random.Next( 0, list.Count-1 );
				Swap( list, i1, i2 );
			}
		}

		#endregion

		#region Swap

		/// <summary>
		/// ???????? ??????? ???? ???????? ? ??????
		/// </summary>
		public static void Swap( IList array, int index1, int index2 )
		{
			object temp = array[index1];
			array[index1] = array[index2];
			array[index2] = temp;
		}
		
		/// <summary>
		/// ???????? ??????? ???? ???????? ? ??????
		/// </summary>
		public static void Swap<T>( IList<T> array, int index1, int index2 )
		{
			T temp = array[index1];
			array[index1] = array[index2];
			array[index2] = temp;
		}

		#endregion

		#region IntersectLists

		/// <summary>
		/// ??????????? ???? ???????. ?????????? ???????, ??????? ?????????? ???????????? ? ???? ???????
		/// </summary>
		public static IList IntersectLists( IList list1, IList list2 )
		{
			// ????? ??????? ??????
			IList result = new ArrayList( list1 );
			
			// ???????? ?? ???????? ??????? ??????
			foreach ( object value in list2 )
			{
				// ?????? ???????? ? ???????? ??????
				int index = result.IndexOf( value );
				if ( index < 0 )
				{
					// ???? ??? ? ??????, ?? ?????? ?? ????????? ??????
					result.RemoveAt( index );
				}
			}
			return result;
		}
		
		/// <summary>
		/// ??????????? ???? ???????. ?????????? ???????, ??????? ?????????? ???????????? ? ???? ???????
		/// </summary>		
		public static List<T> IntersectLists<T>( IList<T> list1, IList<T> list2 )
		{
			List<T> result = new List<T>();
			
			// ???????? ?? ???????? ??????? ??????
			foreach ( T value in list2 )
			{
				// ?????? ???????? ? ?????? ??????
				int index = list1.IndexOf( value );
				if ( index >= 0 )
				{
					// ???? ???? ? ??????, ?? ??????? ? ????????
					result.Add( value );
				}
			}
			return result;
		}

		#endregion

		/// <summary>
		/// ???????? ?????????(???????????????) ????????.
		/// ????????? ?????????? ???????????, ??? ???? ??? ???????? ?????(????????????),
		/// ???? ??? ????? ?? ?????? ??? ??? ??????? ???????, ??? ??????? ????????????
		/// </summary>
		/// <typeparam name="T">??? ???????????? ????????</typeparam>
		/// <param name="values1">??????1</param>
		/// <param name="values2">??????2</param>
		/// <returns>True, ???? ??????? ???????????? ???????????</returns>
		public static bool Equals<T>( T[] values1, T[] values2 )
		{
			#region Assert

			if( values1 == null )
				throw new ArgumentNullException( "values1" );
			if( values2 == null )
				throw new ArgumentNullException( "values2" );
			if( values1.Length != values2.Length )
			{
				string message = String.Format( "??????? ??? ????????? ?????? ????? ?????????? ?????. values1.Length={0}, values2.Length={1}", values1.Length, values2.Length );
				throw new ArgumentException( message );
			}

			#endregion

			// ???????????? ????????? ????????
			for ( int i = 0; i < values1.Length; i++ )
			{
				if( !Equals( values1[i], values2[i] ) )
					return false;
			}
			return true;			
		}

		/// <summary>
		/// ?????????? True, ???? ??????? ?? ????????????.
		/// ???? ????? ??????? ?????? <see cref="Equals{T}"/>
		/// </summary>
		/// <typeparam name="T">??? ???????????? ????????</typeparam>
		/// <param name="values1">??????1</param>
		/// <param name="values2">??????2</param>
		/// <returns>True, ???? ??????? ?? ???????????? ???????????</returns>
		public static bool NotEquals<T>( T[] values1, T[] values2 )
		{
			return !Object.Equals( values1, values2 );
		}
	}
}
