@isTest
public class ObjectListSorterTest {
    
    @istest
    static void standardSortIntegerTest() {
        List<Integer> testList = new List<Integer>{3,6,9,2,1,5,4,7,8};
        Integer startSize = testList.size();
            
        //Test DESC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_INTEGER);
        system.debug(testList);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
        for(Integer i = 0; i < testList.size() - 1; i++) {
            system.assertEquals(testList.size() - i, testList[i], 'One or more elemenets were places in a wrong order');
        }

        //Test ASC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_INTEGER);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
        for(Integer i = 0; i < testList.size() - 1; i++) {
            system.assertEquals(i + 1, testList[i], 'One or more elemenets were places in a wrong order');
        }
    }
    
    @istest
    static void standardSortDecimalTest() {
        List<Decimal> testList = new List<Decimal>{3.3, 8.1, 5.5, 2.7};
        Integer startSize = testList.size();
            
        //Test DESC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_DECIMAL);
        system.debug(testList);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
        system.assertEquals(8.1, testList[0], 'One or more elemenets were places in a wrong order');
        system.assertEquals(5.5, testList[1], 'One or more elemenets were places in a wrong order');
        system.assertEquals(3.3, testList[2], 'One or more elemenets were places in a wrong order');
        system.assertEquals(2.7, testList[3], 'One or more elemenets were places in a wrong order');
        
        //Test ASC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_DECIMAL);
        system.debug(testList);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
        system.assertEquals(8.1, testList[3], 'One or more elemenets were places in a wrong order');
        system.assertEquals(5.5, testList[2], 'One or more elemenets were places in a wrong order');
        system.assertEquals(3.3, testList[1], 'One or more elemenets were places in a wrong order');
        system.assertEquals(2.7, testList[0], 'One or more elemenets were places in a wrong order');
    }
    
    @istest
    static void standardSortStringTest() {
        List<String> testList = new List<String>{'Red', 'Yellow', 'Green'};
        Integer startSize = testList.size();
            
        //Test DESC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_STRING);
        system.debug(testList);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
		system.assertEquals('Yellow', testList[0], 'One or more elemenets were places in a wrong order');
        system.assertEquals('Red', testList[1], 'One or more elemenets were places in a wrong order');
        system.assertEquals('Green', testList[2], 'One or more elemenets were places in a wrong order');
        
        //Test ASC
        ObjectListSorter.standardSort((List<Object>)testList, ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_STRING);
        system.debug(testList);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
		system.assertEquals('Yellow', testList[2], 'One or more elemenets were places in a wrong order');
        system.assertEquals('Red', testList[1], 'One or more elemenets were places in a wrong order');
        system.assertEquals('Green', testList[0], 'One or more elemenets were places in a wrong order');
    }
    
    @istest
    static void standardSortsObjectTest() {
        List<Account> testList = new List<Account>();

        testList.add(new Account(Name = 'B'));
        testList.add(new Account(Name = 'D'));
        testList.add(new Account(Name = 'A'));
        testList.add(new Account(Name = 'E'));
        
        Integer startSize = testList.size();
        
        //Test DESC
        ObjectListSorter.standardSort(testList, 'Name', ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_String);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
		system.assertEquals('E', testList[0].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('D', testList[1].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('B', testList[2].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('A', testList[3].Name, 'One or more elemenets were places in a wrong order');
        
        //Test ASC
        ObjectListSorter.standardSort(testList, 'Name', ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_String);
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
		system.assertEquals('E', testList[3].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('D', testList[2].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('B', testList[1].Name, 'One or more elemenets were places in a wrong order');
        system.assertEquals('A', testList[0].Name, 'One or more elemenets were places in a wrong order');
    }
    
    @istest
    static void customSortsObjectTest() {
		List<Account> testList = new List<Account>();

        testList.add(new Account(Name = 'B', AnnualRevenue = 9000));
        testList.add(new Account(Name = 'D', AnnualRevenue = 2000));
        testList.add(new Account(Name = 'A', AnnualRevenue = 250000));
        testList.add(new Account(Name = 'E', AnnualRevenue = 150000));
        
        Integer startSize = testList.size();
        
        ObjectListSorter.customSort(testList, new AccountRevenueComparator());
        
        system.assertEquals(startSize, testList.size(), 'Some elements were removed from the list while sorting');
		system.assertEquals(2000, testList[0].AnnualRevenue, 'One or more elemenets were places in a wrong order');
        system.assertEquals(9000, testList[1].AnnualRevenue, 'One or more elemenets were places in a wrong order');
        system.assertEquals(150000, testList[2].AnnualRevenue, 'One or more elemenets were places in a wrong order');
        system.assertEquals(250000, testList[3].AnnualRevenue, 'One or more elemenets were places in a wrong order');
    }
}