/************************************************************************

    speaker.scad
    
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

module speaker()
{
    // Speaker body
    move([0,0,-2]) {
        cyl(h=4, d=102);
    
        hull() {
            move([0,0,-3]) cyl(h=2, d=102);
            move([0,0,-5.5 - 16]) cyl(h=1, d=58);
        }

        move([0,0,-25]) cyl(h=8, d1=57, d2=58);

        move([0,0,-34]) cyl(h=10, d=65); // Magnet
        move([0,0,-32]) cyl(h=18, d=57);
    }

    // Speaker mount points
    move([0,0,-0.5]) difference() {
        union() {
            hull() {
                move([0,+(117/2),0]) cyl(h=1,d=6);
                move([0,-(117/2),0]) cyl(h=1,d=6);
            }
            hull() {
                move([+(117/2),0,0]) cyl(h=1,d=6);
                move([-(117/2),0,0]) cyl(h=1,d=6);
            }
        }

        move([0,+(117/2),0]) cyl(h=3,d=4);
        move([0,-(117/2),0]) cyl(h=3,d=4);
        move([+(117/2),0,0]) cyl(h=3,d=4);
        move([-(117/2),0,0]) cyl(h=3,d=4);
    }
}

module render_speaker()
{
    move([4,0,-50.1]) {
        xrot(180) zrot(45) color([0.3,0.3,0.3]) speaker();
    }

    move([-130 + 4,0,-50.1]) {
        xrot(180) zrot(45) color([0.3,0.3,0.3]) speaker();
    }
}