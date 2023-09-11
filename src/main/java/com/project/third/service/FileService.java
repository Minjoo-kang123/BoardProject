package com.project.third.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.third.model.FileVO;

@Service
public interface FileService {
	public void insertFile(FileVO vo);
	public List<FileVO> getFileList(int postid) throws Exception;
	public FileVO getFile(int id) throws Exception;
}