package model;

<<<<<<< HEAD
=======
import java.util.List;

>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
import org.springframework.web.multipart.MultipartFile;

public class FileUpload {
	
	private MultipartFile file;
<<<<<<< HEAD
=======
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
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
<<<<<<< HEAD
=======

	@Override
	public String toString() {
		return "FileUpload [file=" + file + ", files=" + files + "]";
	}
>>>>>>> 622532ef2c92c726edfce34a63728b4849323e3a
	
	

}
