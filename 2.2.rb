file = File.open "2.input", "r"

games = file.read.lines.map do |line|
  {
    n: line.match(/Game (\d+):/)[1].to_i,
    red: line.scan(/(\d+) red/).map{|e| e[0].to_i}.max,
    green: line.scan(/(\d+) green/).map{|e| e[0].to_i}.max,
    blue: line.scan(/(\d+) blue/).map{|e| e[0].to_i}.max,
  }
end

result = games.reduce 0 do |accomulator, game|
  accomulator + game[:red] * game[:green] * game[:blue]
end

puts result
