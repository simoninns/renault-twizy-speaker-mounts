/************************************************************************

    bracket.scad
    
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

module bracket_catch_top()
{
    move([0,-3.5,-6.5]) cuboid([22,5,20], chamfer=0.5);
    move([0,0,3]) cuboid([22,12,3], chamfer=0.5); // Over the Top

    difference() {
        move([0,2,-3.5]) cuboid([22,12,4], chamfer=0.5); // underneath
        move([0,2.5,-2]) cuboid([14,3,2], chamfer=0.5);
    }
}

module bracket_mounting_holes()
{
    move([0,0,-2]) {
        difference() {
            union() {
                hull() {
                    move([0,+(117/2),0]) cyl(h=6,d=10);
                    move([0,-(117/2),0]) cyl(h=6,d=10);
                }
                hull() {
                    move([+(117/2),0,0]) cyl(h=6,d=10);
                    move([-(117/2),0,0]) cyl(h=6,d=10);
                }
            }

            move([0,+(117/2),0]) cyl(h=10,d=4.5);
            move([0,-(117/2),0]) cyl(h=10,d=4.5);
            move([+(117/2),0,0]) cyl(h=10,d=4.5);
            move([-(117/2),0,0]) cyl(h=10,d=4.5);
        }
    }
}

module bracket_speaker_mount()
{
    difference() {
        union() {
            move([0,0,-2]) cyl(h=6, d=112);
            bracket_mounting_holes();
        }
        move([0,0,-3]) cyl(h=10, d=110-6);
    }
}

module bracket_screw_mount(isRight)
{
    twist = (isRight == true) ? -10:10;
    move([0,-3,0]) {
        // Body screw hole at top of clip
        difference() {
            move([66,-35,-13.5 - 4.25]) xrot(twist) yrot(-10) cuboid([16,20,5], chamfer=0.5);
            move([67,-35,-7 - 8]) cyl(h=40,d=4);

            move([66,-45,-13.5 - 4.25]) cuboid([20,4,30]);
            move([66,-25,-13.5 - 4.25]) cuboid([20,4,30]);
        }
        
        // Main stem
        difference() {
            move([74,-35,-30]) cuboid([5,16,40], chamfer=0.5);
            move([60,-35,-11]) xrot(twist) yrot(-10) cuboid([40,20,10]);
        }

        // Foot
        difference() {
            move([68,-35,-47.5]) cuboid([10,16,5], chamfer=0.5);       
            move([67.5,-32,-48.5]) cyl(h=20,d=3.5); // M3 Screw
            move([67.5,-38,-48.5]) cyl(h=20,d=3.5); // Locator pin
        }  
    }
}

module bracket_catch1()
{
    move([0,-62,0]) bracket_catch_top();
    move([0,-65.5,-23.5]) cuboid([22,5,53], chamfer=0.5);
    difference() {
        move([0,-60,-47.5]) cuboid([22,10,5], chamfer=0.5);
        move([5,-58.5,-48.5]) cyl(h=20,d=3.5); // M3 Screw
        move([-5,-58.5,-48.5]) cyl(h=20,d=3.5); // Locator pin
        move([4,0,-52.5]) cyl(h=20,d=110);
    }    
}

module bracket_catch2()
{
    move([0, 62,0]) zrot(180) bracket_catch_top();
    move([0,65.5,-23.5]) cuboid([22,5,53], chamfer=0.5);
    difference() {
        move([0,60,-47.5]) cuboid([22,10,5], chamfer=0.5);
        move([-5,58.5,-48.5]) cyl(h=20,d=3.5); // M3 Screw
        move([+5,58.5,-48.5]) cyl(h=20,d=3.5); // Locator pin
        move([4,0,-52.5]) cyl(h=20,d=110);
    }
}

module render_right_clips(toPrint)
{
    // Render the catches
    if (toPrint) {
        move([40,-30,11]) rotate([90,90,0]) bracket_catch1();
        move([60,-30,11]) rotate([90,-90,0]) bracket_catch2();
        move([-38,-30,46]) rotate([90,0,0]) bracket_screw_mount(true);
    } else {
        bracket_catch1();
        bracket_catch2();
        bracket_screw_mount(true);
    }
}

module render_left_clips(toPrint)
{
    // Render the catches
    if (toPrint) {
        move([40,-30,11]) rotate([90,90,0]) bracket_catch1();
        move([60,-30,11]) rotate([90,-90,0]) bracket_catch2();
        move([-38,-30,46]) rotate([90,0,0]) bracket_screw_mount(false);
    } else {
        move([-130,0,0]) zrot(180) {
            move([-8,0,0]) bracket_catch1();
            move([-8,0,0]) bracket_catch2();
            move([-8,76,0]) bracket_screw_mount(false);
        }
    }
}

module g_mount()
{
    // Speaker support
    move([16,0,-51]) zrot(45) bracket_speaker_mount();

    // Join the catches to the speaker support
    difference() {
        union() {
            move([0,0,-53]) cuboid([22,136,6], chamfer=0.5); // Join the clips
            move([67.5,-38,-53]) cuboid([18,16,6], chamfer=0.5); // Join the screw mount
        }
        move([16,0,0]) zrot(45) move([0,-(117/2),-50]) cyl(h=20,d=4.5); // Clear the screw hole
        
        move([16,0,-50]) cyl(h=20, d=104);

        // Add screw holes for catches and screw mount
        move([5,-58.5,-48.5]) cyl(h=20,d=3.5); // M3 Screw 1
        move([-5,58.5,-48.5]) cyl(h=20,d=3.5); // M3 Screw 2
        move([67.5,-32 - 3,-48.5]) cyl(h=20,d=3.5); // M3 Screw (screw clip)
    }
}

module r_mount()
{
    g_mount();

    // Locator pins
    move([-5,-58.5,-47.5]) cyl(h=5,d=3, chamfer2=0.5); // Locator pin
    move([+5,58.5,-47.5]) cyl(h=5,d=3, chamfer2=0.5); // Locator pin
    move([67.5,-38 - 3,-47.5]) cyl(h=5,d=3, chamfer2=0.5); // Locator pin
}

module l_mount()
{
    yrot(180) move([-8,0,51 * 2 + 4]) {
        g_mount();

        // Locator pins
        move([-5,-58.5,-47.5 - 11]) cyl(h=5,d=3, chamfer1=0.5); // Locator pin
        move([+5,58.5,-47.5 - 11]) cyl(h=5,d=3, chamfer1=0.5); // Locator pin
        move([67.5,-38 - 3,-47.5 -11]) cyl(h=5,d=3, chamfer1=0.5); // Locator pin
    }
}

module render_right_mount(toPrint)
{
    if (toPrint) move([-10,-10,56]) r_mount();
    else r_mount();
}

module render_left_mount(toPrint)
{
    if (toPrint) move([-10,-10,56]) l_mount();
    else move([-130,0,0]) l_mount();
}