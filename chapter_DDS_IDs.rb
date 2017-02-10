# ask for book DOI
print "Enter the DOI of the book: "
book_doi = gets.chomp

# ask for number of chapters
print "Enter the number of chapters the book has: "
numChap = gets.to_i

# output DDSids surrounded by double quotes and separated by commas and a single space
# A DDSid is "chp:{DOI}_{chapter number}"
i = 0
loop do
	i += 1
	puts "\"chp:#{book_doi}_#{i}\", "
	if i == (numChap - 1)
		puts "\"chp:#{book_doi}_#{i + 1}\""
		break
	end
end