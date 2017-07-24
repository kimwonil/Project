package controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 파일다운로드 기능 구현 view
 * */
@Component // id = downLoadCustomView
public class DownLoadCustomView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> map,
		HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		File file = (File) map.get("file");//파일객체 생성
		
		response.setContentType("application/download;charset-UTF-8");
		response.setContentLength((int)file.length());
	
		
		String userAgent = request.getHeader("User-Agent");//브라우져 구분
		
		boolean isInternetExplorer = userAgent.indexOf("MSIE") > -1;
		String fileName = null;
		
		if(isInternetExplorer)
			fileName = URLEncoder.encode(file.getName() , "UTF-8");
		else
			fileName = new String(file.getName().getBytes("UTF-8") , "iso-8859-1") ;
		
		
		response.setHeader("Content-Disposition","attachment;filename=\"" + fileName.replace("+", "%20") + "\";");
		//response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out); // 스프링 전용 읽기 후 바로 쓰기(반복문 필요 없이 가능)
		}
		
		catch(Exception e){
			map.put("error", e.toString());
		}
		finally{
			if(fis != null){
				try{
					fis.close();
				}
				catch(IOException ex){}
			}
		}		
		out.flush();
		
		
	}

	
	
}



