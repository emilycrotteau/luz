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

class ActorEffectStack < ActorEffect
	title				"Stack"
	description "Draws actor many times, stacked in the Z dimension."

	setting 'number', :integer, :range => 1..1000, :default => 1..2, :summary => true
	setting 'smallest', :float, :range => 0.0..9999.0, :default => 1.0..0.5
	setting 'height', :float, :default => 0.0..1.0

	def render
		for i in 0...number
			i.distributed_among(number, 1.0..smallest) { |amount|
				with_scale(amount) {
					with_translation(0,0,(i.to_f/number) * height) {
						yield :child_index => i, :total_children => number
					}
				}
			}
		end
	end
end
