in_n = gets.chomp.to_i

in_n, in_m = gets.chomp.split.map(&:to_i)
in_a = gets.chomp.split.map(&:to_i)

in_w, in_h = gets.chomp.split.map(&:to_i)
in_a = in_w.times.map { gets.chomp.split.map(&:to_i) }

in_s = gets.chomp.chars
