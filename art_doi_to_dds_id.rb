Shoes.app :title => "Article DOI to DDS ID Generator" do

stack do
	@description = banner "This will turn Article DOIs into Article DDS IDs."
    @description.style :size => 14
end

stack do
	para "Enter Article DOIs: "
end


	@edit_box = edit_box :width => 300, :height => 300 do |e|
		@art_dois = @edit_box.text
	end


art_dds_ids = para "DDS IDs will appear here"


	button "Go" do
		if @art_dois.length == 0
			alert("Please enter at least one DOI.", :title => "Idiot!")
		else
			
			doiArray = @art_dois.split("\n").to_a
			doiArray.map! do |single_doi|
				single_doi = "\"art:#{single_doi.gsub(/[\s,]/ ,"")}\""
			end

			art_dds_ids.text = doiArray.join(", "); 
			self.clipboard = art_dds_ids.text
      		alert("DDS IDs for your DOIs have been placed on your clipboard.", :title => nil)
		end

	end

	button "Clear" do
		if art_dds_ids.text == "DDS IDs will appear here"
			alert("Nothing to clear")
			break
		else
		art_dds_ids.text = para "DDS IDs will appear here"
		@art_dois = @edit_box.text.clear
		@edit_box.text = ""
	end
	end

end