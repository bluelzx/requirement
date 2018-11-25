package com.lanzx.rmmsys.encoder;

public class Md5PasswordEncoderImpl extends AbstractPasswordEncoderImpl {

	public Md5PasswordEncoderImpl(){
		setMethod("MD5");
	}
	
	public static void main(String[] str){
		Md5PasswordEncoderImpl impl = new Md5PasswordEncoderImpl();
		System.out.println(impl.encode("admin"));
		
	}
}
