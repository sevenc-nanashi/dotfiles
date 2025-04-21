in_n = read_line.to_i

in_n, in_m = read_line.split.map(&.to_i)
in_a = read_line.split.map(&.to_i)

in_w, in_h = read_line.split.map(&.to_i)
in_a = in_w.times.map { read_line.split.map(&.to_i) }

in_s = read_line.chars
