#!/opt/puppetlabs/puppet/bin/ruby

def flatten_structure(path, structure)
  results = {}

  if structure.is_a? Hash
    structure.each_pair do |name, value|
    new_path = "#{path}_#{name}".gsub(/\-|\//, '_')
    results.merge! flatten_structure(new_path, value)
  end
  elsif structure.is_a? Array
    structure.each_with_index do |value, index|
    new_path = "#{path}_#{index}"
    results.merge! flatten_structure(new_path, value)
  end
  else
    results[path] = structure
  end

  results
end


output=%x{/usr/sbin/dmidecode --type 11 2>/dev/null}

output_hash={}

output.each_line do |line|
  if(line[/tring /])
    key=line.split(':')[0].strip.downcase.tr(" ", "_")
    value=line.match /(?<=:).*/
    output_hash[key] = value.to_s.strip
  end
end

flattened=flatten_structure('dmi_oem',output_hash)

flattened.each_pair do |factname, factvalue|
  Facter.add(factname, :value => factvalue)
end
