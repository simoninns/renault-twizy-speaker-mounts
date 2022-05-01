/************************************************************************

    main.scad
    
    Renault Twizy Speaker Mounts
    Copyright (C) 2022 Simon Inns
    
    This is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

// Local includes
include <speaker.scad>
include <bracket.scad>

// Rendering resolution
$fn=50;

// Select rendering parameters
display = "Assembled"; // [Assembled, Printing]

// Select what to render:
display_speaker = "No"; // [Yes, No]

display_right_mount = "No"; // [Yes, No]
display_right_clips = "No"; // [Yes, No]

display_left_mount = "No"; // [Yes, No]
display_left_clips = "No"; // [Yes, No]

// Render the required items
module main()
{
    toPrint = (display == "Printing") ? true:false;

    // Display selections
    d_speaker = (display_speaker == "Yes") ? true:false;

    d_right_mount = (display_right_mount == "Yes") ? true:false;
    d_right_clips = (display_right_clips == "Yes") ? true:false;

    d_left_mount = (display_left_mount == "Yes") ? true:false;
    d_left_clips = (display_left_clips == "Yes") ? true:false;

    if (d_speaker && (toPrint == false)) render_speaker();

    if (d_right_mount) render_right_mount(toPrint);
    if (d_right_clips) render_right_clips(toPrint);

    if (d_left_mount) render_left_mount(toPrint);
    if (d_left_clips) render_left_clips(toPrint);
}

main();
