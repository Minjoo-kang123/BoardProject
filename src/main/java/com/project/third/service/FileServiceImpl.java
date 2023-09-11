package com.project.third.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.third.mapper.FileMapper;
import com.project.third.model.FileVO;

@Service
public class FileServiceImpl implements FileService{
	@Autowired
	FileMapper filemapper;
	
	@Override
	public void insertFile(FileVO vo) {
		filemapper.insertFile(vo);
	}
	@Override
	public List<FileVO> getFileList(int postid){
		return filemapper.getFileList(postid);
	}
	@Override
	public FileVO getFile(int id) {
		return filemapper.getFile(id);
	}
}