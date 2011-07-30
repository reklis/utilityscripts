#!/opt/local/bin/ruby

class Octagon
  attr_accessor :vertices
  
  def initialize(diameter)
    numsides = 8
    radius = diameter / 2.0
    
    pi = Math::PI
    pi_over_numsides = pi/numsides
    two_pi_over_numsides = 2 * pi / numsides
    d = radius / Math.cos(pi_over_numsides)
    
    verts = []
    for i in (0..numsides-1)
      a = pi_over_numsides + i * two_pi_over_numsides
      x = d * Math.cos(a)
      y = d * Math.sin(a)
      verts.push(x)
      verts.push(y)
    end
    @vertices = verts
  end
  
  def to_s
    "[" + @vertices.join(",") + "]"
  end
end

diameter = ARGV[0].to_f
o = Octagon.new(diameter)
puts o