class Parser
  def initialize(file_path)
    @file = File.read(file_path)
    @lines = @file.split(/\n/)
    @parsed_hash = Hash.new { |hash, key| hash[key] = [] }
  end

  def assemble_logs
    @lines.each do |line|
      path, ip = line.split(/\s/)
      @parsed_hash[path] << ip
    end
    @parsed_hash
  end

  def most_page_views
    most_views = generate_parsed_logs(false).sort_by { |k,v| -v }.to_h
    print_results(most_views, 'visits')
  end

  def unique_page_views
    unique_views = generate_parsed_logs(true).sort_by { |k,v| -v }.to_h
    print_results(unique_views, 'unique views')
  end

  def generate_parsed_logs(unique=false)
    @parsed_hash.each_with_object({}) do |(key, val), hash|
      hash[key] = unique ? val.uniq.size : val.size
    end
  end

  def print_results(logs_hash, string)
    logs_hash.each do |key, val|
      puts "#{key} #{val} #{string}"
    end
  end
end
