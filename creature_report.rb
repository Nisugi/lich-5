=begin
  Creature Damage Report Script
  
  Analyzes all tracked creatures to determine max HP based on damage taken.
  
  Usage:
    ;creature_report                    # Basic report sorted by name  
    ;creature_report sort:max          # Sort by max damage (likely max HP)
    ;creature_report sort:avg          # Sort by average damage 
    ;creature_report min:5             # Require at least 5 samples per creature
    ;creature_report include_fatal     # Include fatal crit deaths in analysis
    ;creature_report export            # Export data to CSV file
    
  The max damage column likely represents the creature's max HP,
  since creatures are typically killed when reaching 0 HP.
=end

# Parse command line arguments
args = script.vars[1..-1] || []
options = {}

args.each do |arg|
  case arg
  when /^sort:(.+)/
    sort_option = $1.to_sym
    if [:name, :max, :avg].include?(sort_option)
      options[:sort_by] = sort_option == :max ? :max_damage : 
                          sort_option == :avg ? :avg_damage : :name
    else
      echo "Invalid sort option: #{$1}. Use name, max, or avg."
      exit
    end
  when /^min:(\d+)/
    options[:min_samples] = $1.to_i
  when 'include_fatal'
    options[:include_fatal] = true
  when 'export'
    options[:export] = true
  when 'help'
    echo "Usage: ;creature_report [sort:name|max|avg] [min:N] [include_fatal] [export]"
    echo "  sort:name     - Sort by creature name (default)"
    echo "  sort:max      - Sort by max damage taken (likely max HP)"
    echo "  sort:avg      - Sort by average damage taken"
    echo "  min:N         - Require at least N samples per creature (default: 2)"
    echo "  include_fatal - Include fatal crit deaths in HP analysis"
    echo "  export        - Export data to CSV file"
    exit
  else
    echo "Unknown option: #{arg}. Use 'help' for usage."
    exit
  end
end

# Check if creature system is available
unless defined?(Creature)
  echo "Error: Creature system not available. Make sure combat tracking is enabled."
  exit
end

# Generate and display report
begin
  if options[:export]
    # Export to CSV
    results = Creature.damage_report(**options)
    
    if results.empty?
      echo "No data to export."
      exit
    end
    
    # Generate filename with timestamp
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    filename = File.join(DATA_DIR, "creature_damage_report_#{timestamp}.csv")
    
    File.open(filename, 'w') do |f|
      f.puts "Creature Name,Sample Count,Min Damage,Max Damage,Avg Damage,Median Damage,Fatal Crits"
      results.each do |data|
        f.puts "\"#{data[:name]}\",#{data[:count]},#{data[:min_damage]},#{data[:max_damage]},#{data[:avg_damage]},#{data[:median_damage]},#{data[:fatal_crits]}"
      end
    end
    
    echo "Report exported to: #{filename}"
    echo "#{results.size} creature types exported."
  else
    # Print to console
    Creature.print_damage_report(**options)
  end
  
rescue StandardError => e
  echo "Error generating report: #{e.message}"
  echo "Make sure combat tracking is enabled and creatures have been tracked."
end