class CutawayController < ApplicationController
  def index
  end

  def about_us
  end

  def contacts
  end
  
  def portfolio
    @gallery = Gallery.where(galleryable_type: "Cutaway").first
  end

  def services    
  end  

  def gallery
    if Cutaway.all.length == 0
      @cutaway = Cutaway.create!
    else
      @cutaway = Cutaway.first
    end
    
    if @cutaway.galleries.length == 0 
      @cutaway.galleries = Gallery.create(galleryable_type: "Cutaway", galleryable_id: 1)
      @cutaway.save!      
    else
      @gallery = @cutaway.galleries.first
    end 
    
    redirect_to gallery_path(@gallery) 
  end  
end
