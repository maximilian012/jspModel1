package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import dto.CalendarDto;

public class CalendarUtil {

	// 문자열 검사 : 빈 문자 -> true
	
	public static boolean nvl(String msg) {
		
		return msg == null || msg.trim().equals("")?true:false; //  msg가 빈문자가 아니면 false return
	}
	//  ifnull("컬럼명", value) 
	
	// 한자리 숫자를 두자리로 만들어 주는 함수: 1 ~ 9 -> 01 ~09
	public static String two(String msg) {
		//       한자리일때 앞에 0을 붙여줌 크면 그대로
		return msg.trim().length()<2?"0" + msg.trim():msg.trim();
	}
	
	// 일별 일정을 모두 볼수있는 callist.jsp로 이동 
	public static String callist(int year, int month, int day) {
		
		String str = "";
		str += String.format("&nbsp;<a href='callist.jsp?year=%d&month=%d&day=%d'>", year, month, day);
		str += String.format("%2d", day);// 일 칸뒤로 밀기
		str += "</a>";
		
		return str;
	}
	
	
	//일정추가
	public static String calwrite(int year, int month, int day) {
		
		String str = "";
		String image = "<img src='images/pen2.png' width='18px' height='18px'>";
		str = String.format("<a href='calwrite.jsp?year=%d&month=%d&day=%d'>%s</a>", year, month, day, image);
		
		return str;
	}
	
	// 문장이 길 경우 단락을 처리하는 함수
	// cgv에서 여사친과 영화보고 데이트 -> cgv에서 ....
	public static String dot3(String msg) {
		
		String str = "";
		if (msg.length() >= 10) {
			str = msg.substring(0, 10); // 0부터 10전까지 잘라내라
			str += "..."; // 10글자 이상일 경우 잘라낸뒤 ... 붙임
			
		}else {
			
			str = msg.trim();
			
		}
		return str;
	}
	
	// 날짜별로 테이블을 생성하기 위한 함수
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		
		String str = "";
		
		
		// 2023 2 16 -> 20230216
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table>";
		
		for (CalendarDto dto : list) {
			// rdate : 약속날짜 같은거
			// rdate : 2023 02 16 11 04 35 -> 20230216
			if (dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				
				str += "  <td style='padding:0px;height:20'>";
				
				str += " <a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";
				
				str += "  <font style='font-size:10px'>";
				
				str += 		dot3(dto.getTitle());
				
				str += "   </font>";
				
				str += " </a>";
				
				str += "  </td>";
				
				
				str += "</tr>";
			}
		}
		str += "</table>";
		
		return str;
	}
	// 날짜를 출력이 보기 좋게 하는 함수
	public static String toDates(String mdate) {
		
		// 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
		
		//202302170942          년                     월                                   일
		String s = mdate.substring(0, 4) + "-" + mdate.substring(4, 6) + "-" + mdate.substring(6, 8) + " " + 
				mdate.substring(8, 10)
		+ ":" + mdate.substring(10) + ":00";
		
		
		Timestamp d = Timestamp.valueOf(s); // s가 결과 그리고 그것을 sdf형식으로 바꾼다
		
		return sdf.format(d);
	}
	
	// 앞에 0이 있는 문자열을 한자리로 변환 08-> 8
	public static String toOne(String msg) {
		
		return msg.charAt(0) == '0'?msg.charAt(1)+"":msg;
		
	}
	
}
