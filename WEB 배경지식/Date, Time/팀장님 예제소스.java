package kr.co.bizspring;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

public class TestCalendar2 {
	Calendar cal;
	SimpleDateFormat sdf;
	ArrayList<String> myList;
	int	thisMonth;
	private int weekNum = 7;
	List<List<String>> weeks ;
	
	
	public TestCalendar2()
	{
		cal = Calendar.getInstance();
		sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		weeks  = new ArrayList();

	}
	
	public void makeMonthDate(int year, int month)
	{
		myList = new ArrayList<String> ();
		this.thisMonth = month;
		
		cal.set(year, month-1, 1);
		int dayOfFirst 	= cal.get(Calendar.DAY_OF_WEEK);		//첫날의 요일
		int lastDay 	= cal.getActualMaximum(Calendar.DATE);  //해당 월의 마지막 일(date)를 반환
		
		cal.set(year, month-1, lastDay);						
		int dayOfLast 	= cal.get(Calendar.DAY_OF_WEEK);		//마지막 날의 요일

		cal.set(year, month-2, 1);					
		int lastDayOfLastMonth 	= cal.getActualMaximum(Calendar.DATE);  //지난 달의 마지막 일
		
		for(int i=dayOfFirst-2;i>-1;i--) {
			cal.set(year, month-2, lastDayOfLastMonth-i);			
			myList.add(sdf.format(cal.getTime()));
		}
		
		for(int i=1;i<=lastDay;i++) {
			cal.set(year, month-1, i);
			myList.add(sdf.format(cal.getTime()));
		}
		
		for(int i=1;i<7-dayOfLast;i++) {
			cal.set(year, month, i);
			myList.add(sdf.format(cal.getTime()));
		}
		
		System.out.println(myList);
		
	}
	
	public void makeMonthInt(int year, int month)
	{
		System.out.println(year +":" + month);
		ArrayList myList1 = new ArrayList();
		
		cal.set(year, month-1, 1);
		int dayOfFirst 	= cal.get(Calendar.DAY_OF_WEEK);
		int lastDay 	= cal.getActualMaximum(Calendar.DATE); //해당 월의 마지막 일(date)를 반환
		
		cal.set(year, month-1, lastDay);
		int dayOfLast 	= cal.get(Calendar.DAY_OF_WEEK);

		cal.set(year, month-2, 1);
		int lastDayOfLastMonth 	= cal.getActualMaximum(Calendar.DATE);
		
		
		System.out.println("dayOfFirst:" + dayOfFirst);
		System.out.println("dayOfLast:" + dayOfLast);
		
		for(int i=dayOfFirst-2;i>-1;i--)
			myList1.add(lastDayOfLastMonth-i);
		
		for(int i=1;i<=lastDay;i++)
			myList1.add(i);
		
		for(int i=1;i<weekNum-dayOfLast;i++)
			myList1.add(i);
		
		System.out.println(myList1);
	}
	
	public static void main(String[] args) {
		TestCalendar2 testCalendar = new TestCalendar2();
		testCalendar.makeMonthDate(2019, 11);
		
		testCalendar.printConsole();
		testCalendar.printTable();
		
		testCalendar.printTableSublist();
		testCalendar.printIterator();
	}

	private void printIterator() {
		String html = "<table>"+"\n";
		for (List<String> week: weeks) {
			html += "<tr>"+"\n";
			Iterator<String> it = week.iterator();
			while(it.hasNext()) {
				String tgtDate = it.next();
				html += "\t" + "<td>"+tgtDate + "</td>"+"\n";
			}
			
			html += "</tr>"+"\n";
		}
		System.out.println(html);
		
	}

	private void printConsole() {
		int cntWeeks = (int) Math.ceil(myList.size()/7);
		
		for(int i=0;i<cntWeeks;i++)
		{
			List weeks = myList.subList(i*7, i*7+7);
			List outData = formatDate(weeks, "DD", false);
			String joined = String.join(" ", outData);
			System.out.println(joined);
		}
		
	}
	
	private void printTableSublist()
	{
		
		int cntWeeks = (int) Math.ceil(myList.size()/7);
		for(int i=0;i<cntWeeks;i++)
			weeks.add(  myList.subList(i*7, i*7+7));
		
		System.out.println(weeks);
	}
	
	private void printTable() {
		int cntWeeks = (int) Math.ceil(myList.size()/7);
		
		String strTable = "<table>\n";
		for(int i=0;i<cntWeeks;i++)
		{
			List weeks = myList.subList(i*7, i*7+7);
			List outData = formatDate(weeks, "DD", false);
			strTable += "<tr>" + "<td>" + String.join("</td><td>", outData) + "</td>" + "</tr>\n";
			
		}
		strTable += "</table>\n";
		System.out.println(strTable);
		
	}

	private List formatDate(List weeks, String string, boolean otherMonth) {
		List outData = new ArrayList<String>();
		Iterator<String> it = weeks.iterator();
		
		while(it.hasNext())
		{
			String td = it.next();
			String month = td.substring(5, 7);
			
			if ( (otherMonth==false) && (this.thisMonth!=Integer.parseInt(month)) ) 
				outData.add("  ");
			else
				outData.add(td.substring(8, 10));
			 
				
		}
		return outData;
	}

}
