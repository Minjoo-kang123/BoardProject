package com.project.third.controller;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.third.model.FileVO;
import com.project.third.service.FileService;

@Controller
public class FileController {
	@Autowired
	private FileService fileservice;
	
	@RequestMapping(value="/post/download", method=RequestMethod.GET)
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "id") int fileId) throws Exception {	
		try {
			FileVO file = fileservice.getFile(fileId);
			String fileName = file.getSavename();
			String downName = file.getOriginalname();

			String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
			String fileRoot = contextRoot+"resources\\fileupload\\";

			File dFile  = new File(fileRoot, fileName);
			int fSize = (int) dFile.length();
			if (fSize > 0) {
				String encodedFilename = "attachment; filename*=" + "UTF-8" + "''" + URLEncoder.encode(downName, "UTF-8");
				encodedFilename = encodedFilename.replaceAll("\\+","");
				response.setContentType("application/octet-stream; charset=utf-8");
				response.setHeader("Content-Disposition", encodedFilename);
				response.setContentLengthLong(fSize);
	
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				in = new BufferedInputStream(new FileInputStream(dFile));
				out = new BufferedOutputStream(response.getOutputStream());
				
				try {
					byte[] buffer = new byte[4096];
				 	int bytesRead=0;
				 	while ((bytesRead = in.read(buffer))!=-1) {
						out.write(buffer, 0, bytesRead);
					}
					out.flush();
				}
				finally {
					in.close();
					out.close();
				}
		    } else {
		    	throw new FileNotFoundException("파일이 없습니다.");
		    }
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}