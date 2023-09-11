package com.project.third.mapper;

import java.util.List;

import com.project.third.model.FileVO;

public interface FileMapper {
	public void insertFile(FileVO vo);
	public List<FileVO> getFileList(int postid);
	public FileVO getFile(int id);
}
