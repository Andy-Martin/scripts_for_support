Shoes.app :title => "Support Guys Toolkit", :width => 1000, :height => 500 do 
background "#dfe3f7".."#b7bfec"
border(black,
        strokewidth: 4) 
# This flow contains the entire left side of the window - this contains the book to chapter function
flow(:width => 498) {

  stack(:margin_left => 10, :margin_top => 10, :width => 480) do
    @description = banner "This will turn a given book DOI into chapter DDS IDs for a given number of chapters"
    @description.style :size => 14
  end

# Here are input boxes
  stack(margin_left: 80, margin_top: 30) do
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

stack(:margin_left =>10) do
  @contents = "DDS IDs will appear here."
end
 

  stack(margin_left: 30, margin_top: 20, width: 80) do
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
          
# Builds the array of chapter DDS ids
      else

        i = 0
        idArray = []

        loop do
          i += 1
          idArray.push("\"chp:#{@book_doi}_#{i}\"")
          if i == (@numChap.to_i)
          break
        end
    end
  
# Joins the array and alert message to tell user the operation is complete
    @contents = idArray.join(", ");
      self.clipboard = @contents
        alert("DDS IDs for #{@book_doi.to_s} have been placed on your clipboard.", :title => nil)
      end
   end

# Clears the text boxes and the array
      @bookClear = button("Clear").click do
        if @contents.to_s == "DDS IDs will appear here."
          alert("Nothing to clear.", :title => nil)
          
          else
          @contents = "DDS IDs will appear here."
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
#central border
flow(:width => 4, :height => 1.0) do
  border(black,
        strokewidth: 4)
end

# This flow contains the entire right side of the window - this contains the article/chapter to DDS id function
flow(:width => 498) {


stack(margin_left:10, margin_top:10, :width => 475) do
    @description = banner "This will turn a list of article or chapter DOIs into DDS IDs."
      @description.style :size => 14
      end

      stack(margin_left:75) do 
        list_box items: ["Article", "Chapter"],
     width: 120, choose: "Article" do |list|
       @type.text =  "Enter #{list.text} DOIs: "
   end
   
  end

stack(margin_left: 40, margin_top:20) do

  flow(:width => 460) {
    @type = para "Enter Article DOIs: "
    
    @edit_box = edit_box :width => 250, :height => 300, :right => 50 do |y|
    @art_dois = @edit_box.text
    end
  }
end

stack do 
@art_dds_ids = "DDS IDs will appear here."
end

stack(margin_left:30) do 
  flow(:width => 500) { 
  button "Go" do
    if @art_dois.to_s.length == 0
      alert("Please enter at least one DOI.", :title => "Idiot!")
      
      elsif @type.to_s == "Enter Chapter DOIs: "
        doiArray = @art_dois.split("\n").to_a
        doiArray.map! do |single_doi|
        single_doi = "\"chp:#{single_doi.gsub(/[\s,]/ ,"")}\""
        end

      @art_dds_ids = doiArray.join(", "); 
      self.clipboard = @art_dds_ids.to_s
          alert("DDS IDs for your Chapter DOIs have been placed on your clipboard.", :title => nil)

# Note: these book DDSids are not correct! For books you need to strip out the publisher prefix in the doi
# TODO: use regex to check and get rid of prefix

=begin 
     
     elsif @type.to_s == "Enter Book DOIs: "
         doiArray = @art_dois.split("\n").to_a
       doiArray.map! do |single_doi|
       single_doi = "\"bok:#{single_doi.gsub(/[\s,]/ ,"")}\""
       end

     @art_dds_ids = doiArray.join(", "); 
     self.clipboard = @art_dds_ids.to_s
         alert("DDS IDs for your Book DOIs have been placed on your clipboard.", :title => nil)

=end
        
      else
      doiArray = @art_dois.split("\n").to_a
        doiArray.map! do |single_doi|
        single_doi = "\"art:#{single_doi.gsub(/[\s,]/ ,"")}\""
        end

      @art_dds_ids = doiArray.join(", "); 
      self.clipboard = @art_dds_ids.to_s
          alert("DDS IDs for your Article DOIs have been placed on your clipboard.", :title => nil)
    end

  
  end
   
    @artClear = button("Clear").click do
        if @art_dds_ids.to_s == "DDS IDs will appear here."
          alert("Nothing to clear.", :title => nil)
      
          else
          @art_dds_ids = "DDS IDs will appear here."
          @art_dois = @edit_box.to_s.clear
          @edit_box.text = ""
        end
    end
  }
end
#end of second flow
}
end
