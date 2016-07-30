#!/opt/puppetlabs/puppet/bin/ruby

if File.executable? '/usr/sbin/dmidecode'
  output=%x{/usr/sbin/dmidecode --type 11 2>/dev/null}

  output.each_line do |line|
    if(line[/tring /])
      factname="dmi_oem_"<<line.split(':')[0].strip.downcase.tr(" ", "_")
      value=line.match /(?<=:).*/
      cleaned=value.to_s.strip
      Facter.add(factname, :value => cleaned)
    end
  end
end
