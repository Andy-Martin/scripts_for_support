Shoes.app :title => "Support Guys Toolkit", :width => 1000 do 
background "#dff5fc".."#6677cd"
border("#ece4b7",
        strokewidth: 6) 

flow(:width => 500) {

  stack(:margin_left => 10, :width => 480) do
    @description = banner "This will turn a given book DOI into chapter DDS IDs for a given number of chapters"
    @description.style :size => 14
  end

  stack(margin_left: 40) do
    flow {
    para "Enter book DOI: "
    @input_doi = edit_line do |e|
      @book_doi = @input_doi.text
    end
    }
  flow {
    para "Enter number of chapters: "
    @input_chap = edit_line :width => 40 do |x|
     @numChap = @input_chap.text
   end
  } 
end

stack(:margin_left =>10).hide do
  @contents = para "DDS IDs will appear here."
end
 

  stack(margin_left: 10, width: 80) do
    flow(:width => 450) {
     @bookGo = button "Go" do
    
# checking the text boxes have something in them
    if @book_doi.to_s.length == 0
      alert("Please enter a DOI.", :title => "Idiot!")
    

    elsif @numChap.to_s.length == 0
        alert("Please enter the number of chapters.", :title => "You Fool!")

      elsif @numChap.to_i == 1
        alert("A book should really have more than one chapter, but I've added 1 chapter DDS ID to your clipboard anyway.", :title => "You've probably done something wrong")
        self.clipboard = "\"chp:#{@book_doi}_1\""
          

      else

        i = 0
        idArray = []

        loop do
          i += 1
          idArray.push("\"chp:#{@book_doi}_#{i}\"")
          if i == (@numChap.to_i - 1)
          break
        end
    end
  

    @contents = idArray.join(", ");
      self.clipboard = @contents
        alert("DDS IDs for #{@book_doi.to_s} have been placed on your clipboard.", :title => nil)
      end
   end

      @bookClear = button("Clear").click do
        if @contents.to_s == "DDS IDs will appear here."
          alert("Nothing to clear.")
          
          else
          @contents = para "DDS IDs will appear here."
          @numChap = @input_chap.text.clear 
          @input_chap.text = ""
          @book_doi = @input_doi.text.clear
          @input_doi.text = ""
        end
      end
    }
  end
#end of flow
}

flow(:width => 500) {

  stack(margin_left:10, :width => 475) do
    @description = banner "This will turn Article DOIs into Article DDS IDs."
      @description.style :size => 14
  end

stack(margin_left: 40) do

  flow(:width => 460) {
    para "Enter Article DOIs: "



    @edit_box = edit_box :width => 250, :height => 300 do |y|
    @art_dois = @edit_box.text
    end
  }
end

stack.hide do 
@art_dds_ids = para "DDS IDs will appear here."
end

stack do 
  flow(:width => 500) { 
  button "Go" do
    if @art_dois.to_s.length == 0
      alert("Please enter at least one DOI.", :title => "Idiot!")
      else
      doiArray = @art_dois.split("\n").to_a
        doiArray.map! do |single_doi|
        single_doi = "\"art:#{single_doi.gsub(/[\s,]/ ,"")}\""
        end

      @art_dds_ids = doiArray.join(", "); 
      self.clipboard = @art_dds_ids.to_s
          alert("DDS IDs for your DOIs have been placed on your clipboard.", :title => nil)
    end

  
  end
   
    @artClear = button("Clear").click do
        if @art_dds_ids.to_s == "DDS IDs will appear here."
          alert("Nothing to clear.")
      
          else
          @art_dds_ids = para "DDS IDs will appear here."
          @art_dois = @edit_box.to_s.clear
          @edit_box.text = ""
        end
    end
  }
end
#end of second flow
}
end
