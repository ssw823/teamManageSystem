package action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.struts2.ServletActionContext;

/**
 * 文件上传管理类
 * @author Administrator
 *
 */
public class UploadAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private File Filedata;
	private String FiledataFileName;
	
	public String uploadpic() throws IOException{
		getResp().setContentType("text/html;charset=UTF-8");
        PrintWriter out = getWriter();
		
		String path = ServletActionContext.getServletContext().getRealPath("/uploadfile/");
		FileInputStream is = new FileInputStream(Filedata);
		String dateString = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String fileName = dateString + "_" + FiledataFileName;
		FileOutputStream os = new FileOutputStream(path + "/" + fileName);
		byte buffer[] = new byte[8192];
		int count = 0;
		while ((count = is.read(buffer)) > 0) {
			os.write(buffer, 0, count);
		}
		os.close();
		is.close();
		getResp().setHeader("Cache-Control", "no-store");
		getResp().setHeader("Pragma", "no-cache");
		getResp().setDateHeader("Expires", 0);
		getResp().setCharacterEncoding("utf-8");
		out.write("{\"success\":\"true\",\"filename\":\""+fileName+"\"}");
		
		getReq().getSession().setAttribute("fileName", fileName);
		out.flush();
		out.close();
		return null;
	}

	public File getFiledata() {
		return Filedata;
	}

	public void setFiledata(File filedata) {
		Filedata = filedata;
	}

	public String getFiledataFileName() {
		return FiledataFileName;
	}

	public void setFiledataFileName(String filedataFileName) {
		FiledataFileName = filedataFileName;
	}
	
	
}
