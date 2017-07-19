package model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileUpload {
	
	private MultipartFile file;
	private List<MultipartFile> files;

	
	
	
	
	
	public FileUpload() {
		super();
	}

	public FileUpload(List<MultipartFile> files) {
		super();
		this.files = files;
	}

	public FileUpload(MultipartFile file) {
		super();
		this.file = file;
	}

	public List<MultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	@Override
	public String toString() {
		return "FileUpload [file=" + file + ", files=" + files + "]";
	}
	
	

}
