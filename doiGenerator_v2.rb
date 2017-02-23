Shoes.app :title => "DDS ID Generator" do

background "#dff5fc".."#6677cd"
border("#ece4b7",
        strokewidth: 6)

  stack(margin_left:10) do
    @description = banner "This little app will put all the chapter DDS IDs for a given book on your clipboard so you can paste them somewhere."
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

  @contents = para "DDS IDs will appear here."

  end

  stack(margin_left: 40, width: 80) do
    flow {
      button "Go" do
    
# checking the text boxes have something in them
    if @book_doi.length == 0
      alert("Please enter a DOI.", :title => "Idiot!")

    elsif @numChap.length == 0
        alert("Please enter the number of chapters.", :title => "You Fool!")

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
  end

    @contents.text = idArray.join(", ");
 
      self.clipboard = @contents.text
      alert("DDS IDs for #{@book_doi.text} have been placed on your clipboard.", :title => nil)
   end
}
    flow {
      button("Clear").click do
        if @contents.text == "DDS IDs will appear here."
          alert("Nothing to clear.")
          break
          else
          @contents.text = para "DDS IDs will appear here."
          @numChap = @input_chap.text.clear 
          @input_chap.text = ""
          @book_doi = @input_doi.text.clear
          @input_doi.text = ""
        end
      end
    }
  end
end
