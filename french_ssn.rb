require "date"
require "yaml"
require 'byebug'


PATTERN = /^(?<gender>[12])\s?(?<year>\d{2})\s?(?<month>0[1-9]|1[0-2])\s?(?<department>\d{2}|2[AB])(\s?\d{3}){2}\s?(?<key>\d{2})/
DEPARTMENTS = YAML::load_file(File.join(__dir__, './data/french_departments.yml'))
def french_ssn_info(ssn)
  return "The number is invalid" if ssn == ""

  match_data = ssn.match(PATTERN)

  gender = match_data[:gender].to_i == 1 ? "man" : "woman"
  month = Date::MONTHNAMES[match_data[:month].to_i]
  year = 1900 + match_data[:year].to_i
  department = DEPARTMENTS[match_data[:department]]

  key = match_data[:key].to_i

  number = ssn.gsub(/\s/, "")
  ssn_without_key = number[0...(number.length - 2)].to_i

  remainder = (97 - ssn_without_key) % 97

  if remainder != key
    return "The number is invalid"
  else
    return "a #{gender}, born in #{month}, #{year} in #{department}."
  end
end

puts french_ssn_info("1 84 12 76 451 089 45")
