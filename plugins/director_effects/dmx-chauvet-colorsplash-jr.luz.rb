 ###############################################################################
 #  Copyright 2006 Ian McIntosh <ian@openanswers.org>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation; either version 2 of the License, or
 #  (at your option) any later version.
 #
 #  This program is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU Library General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
 #  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 ###############################################################################

class DirectorEffectDMXChauvetColorSplashJR < DirectorEffect
	title				"DMX Chauvet ColorSplash Jr"
	description "A 5-channel LED light with RGB and strobe control."

	setting 'channel', :integer, :range => 1..255, :simple => true, :summary => 'channel %'

	setting 'red', :float, :range => 0.0..1.0
	setting 'green', :float, :range => 0.0..1.0
	setting 'blue', :float, :range => 0.0..1.0

	setting 'strobe', :float, :range => 0.0..1.0

	def tick
		$engine.with_dmx(channel) { |dmx|
			# Channel 1 is "Reserved"

			# 000-001 Blackout
			# 002-127 Strobe: Slow > Fast
			# 128-255 Intensity: 0% > 100%
			if strobe == 0.0
				# We use RGB amounts (below) for brightness control instead
				dmx.set(2, 255)
			else
				dmx.set(2, 2 + (strobe * 125))
			end

			# RGB
			dmx.add(3, 255 * red)
			dmx.add(4, 255 * green)
			dmx.add(5, 255 * blue)
		}
	end
end
