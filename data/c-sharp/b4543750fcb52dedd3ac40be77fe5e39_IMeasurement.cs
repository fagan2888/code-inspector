/*
 * Data types for the ProbeNet Protocol in C#
 * Copyright (C) Wolfgang Silbermayr
 * Copyright (C) Florian Marchl
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
using System;
#if MICRO_FRAMEWORK
using System.Collections;
#else
using System.Collections.Generic;
#endif

namespace ProbeNet.Messages.Interface
{
    /// <summary>
    /// Measurement.
    /// </summary>
    public interface IMeasurement
    {
        /// <summary>
        /// Gets the UUID.
        /// </summary>
        /// <value>
        /// The universally unique identifier according to <a href="">RFC 4122</a>. This identifies the measurement.
        /// It is different for each measurements.
        /// </value>
        Guid Uuid
        {
            get;
        }

        /// <summary>
        /// Gets a value indicating whether this <see cref="IMeasurement"/> is active.
        /// </summary>
        /// <value>
        /// <c>true</c> if active; otherwise, <c>false</c>.
        /// </value>
        bool Active
        {
            get;
        }

        /// <summary>
        /// Gets the alignment.
        /// </summary>
        /// <value>
        /// The alignment of the measurement. Must be included if at least one of the fields is set <c>true</c> in
        /// the measurement description as specified in <see cref="IMeasurementDescription"/>
        /// </value>
        /// <seealso cref="IAlignment"/>
        IAlignment Alignment
        {
            get;
        }

        /// <summary>
        /// Gets the results.
        /// </summary>
        /// <value>
        /// The results of the measurement. The key is a string for each result id defined in the measurement
        /// description; The value contains the corresponding result value as specified in its result description.
        /// </value>
        /// <seealso cref="IMeasurementDescription"/>
        /// <seealso cref="IResultDescription"/>
#if MICRO_FRAMEWORK
        IDictionary Results
#else
        IDictionary<string, Nullable<double>> Results
#endif

        {
            get;
        }

        /// <summary>
        /// Gets the curve.
        /// </summary>
        /// <value>
        /// The curve is represented by a list of points. The curve points are represented as an n-dimensional array
        /// where n is the degree of the coordinate system as specified in the coresponding curve description.
        /// </value>
        /// <example>In order to represent a two-dimensional curve a list containing two-dimensional arrays (one for
        /// each point) must be returned.</example>
        /// <seealso cref="IMeasurementDescription"/>
        /// <seealso cref="ICurveDescription"/>
#if MICRO_FRAMEWORK
        IList Curve
#else
        IList<double[]> Curve
#endif
        {
            get;
        }

        /// <summary>
        /// Gets the images.
        /// </summary>
        /// <value>
        /// The images generated by the measurements. The key is a string for each image id defined in the measurement
        /// description; The value containes the PNG image data as byte array.
        /// </value>
        /// <seealso cref="IMeasurementDescription"/>
        /// <seealso cref="ICurveDescription"/>
#if MICRO_FRAMEWORK
        IDictionary Images
#else
        IDictionary<string, byte[]> Images
#endif
        {
            get;
        }

        /// <summary>
        /// Gets the tag.
        /// </summary>
        /// <value>
        /// The tag is some additional text to be stored with the measurement (user comments, custom numbering, etc.).
        /// </value>
        string Tag
        {
            get;
        }
    }
}