seats = IO.foreach("input.txt").map{ |x| x.gsub(/[FL]/, '0').gsub(/[BR]/, '1').to_i(2) }.collect{|x| x }
p Range.new(*seats.minmax).collect{|x| x }.difference(seats)