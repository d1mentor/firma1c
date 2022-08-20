class GalleriesController < ApplicationController
  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    flash[:error] = "Не получилось загрузить фото :(" unless @gallery.save
    redirect_to polymorphic_path(@gallery.galleryable)
  end

  def set_img_to_destroy
    @gallery = Gallery.find(params[:id])
  end

  def destroy_img
    @gallery = Gallery.find(params[:gallery][:id])

    to_destroy = []
    params[:images].values.each do |value|
      @gallery.images.each do |img|
        if img.identifier == value
          to_destroy << img
        end  
      end  
    end  

    @gallery.images -= to_destroy
    @gallery.save

    respond_to do |format|
      format.html { redirect_to gallery_path(@gallery) }
      format.json { head :no_content }
    end
  end

  def load_img
    @gallery = Gallery.find(params[:id])
  end

  def add_img
    @gallery = Gallery.find(params[:gallery][:id])
    gallery_imgs = @gallery.images
    gallery_imgs += gallery_params[:images]
    @gallery.images = gallery_imgs
    @gallery.save

    respond_to do |format|
      format.html { redirect_to gallery_path(@gallery) }
      format.json { head :no_content }
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    @gallery.name = gallery_params[:name]
    @gallery.save

    respond_to do |format|
      format.html { redirect_to gallery_path(@gallery) }
      format.json { head :no_content }
    end
  end

  def delete

  end

  def destroy
    @gallery = Gallery.find(params[:id])
    back_url = polymorphic_path(@gallery.galleryable)
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to back_url, notice: "Галерея успешно удалена." }
      format.json { head :no_content }
    end
  end

  private 

  def gallery_params
    params.require(:gallery).permit(:id, :name, :galleryable_type, :galleryable_id, {images: []}, {checkbox: []})
  end
end
