
class LineAnalyzer

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    highest_wf_words = []
    calculate_word_frequency
  end

  #[hassan=>3, "Mohamned"=>2, "Ahmed"=>1]
  def calculate_word_frequency()
    words = content.split(" ")
    count = Hash.new(0)
    words.each do |word|
      count[word.downcase] += 1
    end
    @highest_wf_count = count.values.max
    @highest_wf_words = count.select{|k, v| v == @highest_wf_count}.keys.to_a
  end
end

class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize()
    @analyzers = Array.new(0)
  end
  
  
  def analyze_file()
    file = File.open("test.txt", "r")
    file.each_line.with_index do |line, line_num|
      @analyzers << LineAnalyzer.new(line, line_num + 1)
    end
    file.close
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = @analyzers.sort_by{|analyzer| analyzer.highest_wf_count}.last.highest_wf_count
    @highest_count_words_across_lines = @analyzers.select{|analyzer| @highest_count_across_lines == analyzer.highest_wf_count}

  end

  def print_highest_word_frequency_across_lines()
    put "The following words have the highest word frequency per line"
    @highest_count_words_across_lines.each do |a|
      puts "#{a.highest_wf_words}(appears in line #{a.line_number})"
    end
  end
end
