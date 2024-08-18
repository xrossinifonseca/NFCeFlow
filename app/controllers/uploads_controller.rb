require 'mimemagic'

class UploadsController < ApplicationController

def index
  @uploads = current_customer.uploads
end



def create
   file = params[:file]

  if !file.present?
    flash[:error] = "File cant be blank"
    return redirect_to new_upload_path
  end


    mime_type = MimeMagic.by_path(file.path)

    if mime_type.subtype == "xml"

      proccess_xml_file(file)

    elsif mime_type.subtype == "zip"

      proccess_zip_file(file)

    else
      flash[:error] = "The file must be in XML or ZIP format. Please upload a file with one of the supported extensions."
      return redirect_to new_upload_path
    end
end




def proccess_xml_file(file)

      file_content = file.read

      file_temp = StringIO.new(file_content)

      upload = Upload.create!(file_name:file.original_filename, status:"processing", customer_id:current_customer.id)

      XmlProcessingWorkerJob.perform_async(file_content ,current_customer.id,upload.id)

      flash[:success] = "your xml file is being processed"

      Rails.logger.error "Customer #{current_customer.name} user processed a xml file on the system"

      redirect_to uploads_path
end



def proccess_zip_file(file)
      ZipFileProcessingService.process(file,current_customer.id)

      flash[:success] = "your zip file is being processed"

      Rails.logger.error "Customer #{current_customer.name} user processed a zip file on the system"

      redirect_to uploads_path
end
end
