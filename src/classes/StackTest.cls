@isTest
public class StackTest {
    
    @isTest
    static void sizeTest() {
        Stack st = new Stack();
        System.assertEquals(0, st.size(), 'Size was not calculated right');
        
        st.push('A');
        System.assertEquals(1, st.size(), 'Size was not calculated right');
        
        st.pop();
        System.assertEquals(0, st.size(), 'Size was not calculated right');
        
        st.push('A');
        st.push('B');
        st.push('C');
        
        System.assertEquals(3, st.size(), 'Size was not calculated right');
    }
    
    @isTest
    static void isEmptyTest() {
        Stack st = new Stack();
        System.assertEquals(true, st.isEmpty(), 'isempty check return wrong value');
        
        st.push('A');
        System.assertEquals(false, st.isEmpty(), 'isempty check return wrong value');
        
        st.pop();
        System.assertEquals(true, st.isEmpty(), 'isempty check return wrong value');
        
        st.push('A');
        st.push('B');
        st.push('C');
        
        System.assertEquals(false, st.isEmpty(), 'isempty check return wrong value');
    }
    
    @isTest
    static void testPushWithObjNotOrderd() {
        Stack st = new Stack();
        st.push(2);
        st.push(1);
        st.push(3);
        st.push(5);
        
        System.assertEquals(4, st.objList.size(), 'Not all elements were added');
        System.assertEquals(2, st.objList[0], 'Element added on wrong place');
        System.assertEquals(1, st.objList[1], 'Element added on wrong place');
        System.assertEquals(3, st.objList[2], 'Element added on wrong place');
        System.assertEquals(5, st.objList[3], 'Element added on wrong place');
    }
    
  	@isTest
    static void testPushWithObjOrderd() {
        Stack st = new Stack(ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_INTEGER);
        st.push(5);
        st.push(1);
        
        System.assertEquals(5, st.objList[0], 'Element added on wrong place');
        System.assertEquals(1, st.objList[1], 'Element added on wrong place');
        
        st.push(3, false);
        System.assertEquals(1, st.objList[0], 'Element added on wrong place');
        System.assertEquals(3, st.objList[1], 'Element added on wrong place');
        System.assertEquals(5, st.objList[2], 'Element added on wrong place');
        
        st.push(2);
        System.assertEquals(1, st.objList[0], 'Element added on wrong place');
        System.assertEquals(3, st.objList[1], 'Element added on wrong place');
        System.assertEquals(5, st.objList[2], 'Element added on wrong place');
        System.assertEquals(2, st.objList[3], 'Element added on wrong place');
        
        st.push(7, false);
        system.debug(st.objList);
        System.assertEquals(1, st.objList[0], 'Element added on wrong place');
        System.assertEquals(2, st.objList[1], 'Element added on wrong place');
        System.assertEquals(3, st.objList[2], 'Element added on wrong place');
        System.assertEquals(5, st.objList[3], 'Element added on wrong place');
        System.assertEquals(7, st.objList[4], 'Element added on wrong place');
    }
    
    @isTest
    static void testPushWithsObjOrderd() {
        Stack st = new Stack('Name', ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_STRING);
        st.push(new Account(Name = 'B'));
        st.push(new Account(Name = 'D'));
        
        System.assertEquals('B', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('D', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        
        st.push(new Account(Name = 'A'), false);
        
        System.assertEquals('D', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('B', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        System.assertEquals('A', ((Account)st.objList[2]).Name, 'Element added on wrong place');
        
        st.push(new Account(Name = 'E'));
        System.assertEquals('D', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('B', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        System.assertEquals('A', ((Account)st.objList[2]).Name, 'Element added on wrong place');
        System.assertEquals('E', ((Account)st.objList[3]).Name, 'Element added on wrong place');
    }
    
    @isTest
    static void testPushWithsObjComparatorOrderd() {
        Stack st = new Stack(new AccountRevenueComparator());
        
        st.push(new Account(Name = 'B', AnnualRevenue = 9000));
        st.push(new Account(Name = 'D', AnnualRevenue = 2000));
        
        System.assertEquals('B', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('D', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        
        st.push(new Account(Name = 'A', AnnualRevenue = 250000), false);
        
        System.assertEquals('D', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('B', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        System.assertEquals('A', ((Account)st.objList[2]).Name, 'Element added on wrong place');

        st.push(new Account(Name = 'E', AnnualRevenue = 150000));
        System.assertEquals('D', ((Account)st.objList[0]).Name, 'Element added on wrong place');
        System.assertEquals('B', ((Account)st.objList[1]).Name, 'Element added on wrong place');
        System.assertEquals('A', ((Account)st.objList[2]).Name, 'Element added on wrong place');
        System.assertEquals('E', ((Account)st.objList[3]).Name, 'Element added on wrong place');
    }
    
    @isTest
	static void testPopWithObjNotOrderd() {
        Stack st = new Stack();
        st.push(2);
        st.push(1);
        st.push(3);
        st.push(5);
        
        
        System.assertEquals(5, st.pop(), 'Wromg element was returned');
        System.assertEquals(3, st.pop(), 'Wromg element was returned');
        System.assertEquals(1, st.pop(), 'Wromg element was returned');
        System.assertEquals(2, st.pop(), 'Wromg element was returned');
        System.assertEquals(0, st.objList.size(), 'Not all elements were poped');
        
        //Exceptopn test
        Boolean isExceptionThrown = false;
        String exceptionType;
        try {
            st.pop();
        } catch(Exception ex) {
            isExceptionThrown = true;
            exceptionType = ex.getTypeName();
        }
		
        System.assert(isExceptionThrown, 'Exception expected to be thown but wasnt');
        System.assertEquals('Stack.StackUnderflowException', exceptionType, 'Exception expected to be thown but wasnt');
    }
    
    @isTest
    static void testQuickPopWithObjNoOrderd() {
        Stack st = new Stack();
        st.push(2);
        st.push(1);
        st.push(3);
        st.push(5);
        
        System.assertEquals(5, st.pop(false), 'Wromg element was returned');
        System.assertEquals(3, st.pop(false), 'Wromg element was returned');
        System.assertEquals(1, st.pop(false), 'Wromg element was returned');
        System.assertEquals(2, st.pop(false), 'Wromg element was returned');
        System.assertEquals(0, st.objList.size(), 'Not all elements were poped');
    }
    
   @isTest
    static void testPopWithObjOrderd() {
		Stack st = new Stack(ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_INTEGER);
        st.push(2);
        st.push(1);
        st.push(3);
        st.push(5);
        
        System.assertEquals(5, st.pop(false), 'Wromg element was returned');
        System.assertEquals(3, st.pop(), 'Wromg element was returned');
        System.assertEquals(2, st.pop(false), 'Wromg element was returned');
        System.assertEquals(1, st.pop(), 'Wromg element was returned');
        System.assertEquals(0, st.objList.size(), 'Not all elements were poped');
    }
    
    @isTest
    static void testPopWithsObjOrderd() {
        Stack st = new Stack('Name', ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_STRING);
        st.push(new Account(Name = 'B'));
        st.push(new Account(Name = 'D'));
        st.push(new Account(Name = 'A'));
        st.push(new Account(Name = 'E'));
        
        System.assertEquals('E', ((Account)st.pop()).Name, 'Wromg element was returned');
        System.assertEquals('A', ((Account)st.pop(false)).Name, 'Wromg element was returned');
        System.assertEquals('B', ((Account)st.pop()).Name, 'Wromg element was returned');
        System.assertEquals('D', ((Account)st.pop(false)).Name, 'Wromg element was returned');
        System.assertEquals(0, st.objList.size(), 'Not all elements were poped');
    }
    
    @isTest
    static void testPushPopWithSobjectList() {
        List<Account> testList = new List<Account>();

        testList.add(new Account(Name = 'B'));
        testList.add(new Account(Name = 'D'));
        testList.add(new Account(Name = 'A'));
        testList.add(new Account(Name = 'E'));
        
        Stack st = new Stack(testList, 'Name', ObjectListSorter.SortOrder.DESCENDING, ObjectListSorter.FieldType.TYPE_STRING);
        
        System.assertEquals('E', ((Account)st.pop()).Name, 'Wromg element was returned');
        System.assertEquals('A', ((Account)st.pop(false)).Name, 'Wromg element was returned');
        
        st.push(new Account(Name = 'F'));
        st.push(new Account(Name = 'L'), false);
        
        System.assertEquals('B', ((Account)st.pop()).Name, 'Wromg element was returned');
    }
    
    @isTest
    static void testPushPopWithsObjComparatorOrderd() {
        List<Account> testList = new List<Account>();

        testList.add(new Account(Name = 'B', AnnualRevenue = 9000));
        testList.add(new Account(Name = 'D', AnnualRevenue = 2000));
        testList.add(new Account(Name = 'A', AnnualRevenue = 250000));
        testList.add(new Account(Name = 'E', AnnualRevenue = 150000));
        
        Stack st = new Stack(testList, new AccountRevenueComparator());
        
        st.push(new Account(Name = 'Y', AnnualRevenue = 90000));
        st.push(new Account(Name = 'Z', AnnualRevenue = 20000));
        
        System.assertEquals('A', ((Account)st.pop(false)).Name, 'Wromg element was returned');
        System.assertEquals('E', ((Account)st.pop()).Name, 'Wromg element was returned');
        
        st.push(new Account(Name = 'K', AnnualRevenue = 15000), false);
        System.assertEquals('Y', ((Account)st.pop()).Name, 'Wromg element was returned');
        System.assertEquals('Z', ((Account)st.pop()).Name, 'Wromg element was returned');
        System.assertEquals('K', ((Account)st.pop()).Name, 'Wromg element was returned');
    }
    
    @isTest
    static void testPushPopWithsObjOrderd() {
        List<Integer> testList = new List<Integer>{3,6,9,2,1,5,4,7,8};
            
		Stack st = new Stack(testList, ObjectListSorter.SortOrder.ASCENDING, ObjectListSorter.FieldType.TYPE_INTEGER);
        
        System.assertEquals(8, st.pop(), 'Wromg element was returned');
        System.assertEquals(7, st.pop(), 'Wromg element was returned');
        
        st.push(12);
        st.push(10, false);
        st.push(11, false);
        st.push(15, false);
        
		System.assertEquals(15, st.pop(), 'Wromg element was returned');
        System.assertEquals(12, st.pop(), 'Wromg element was returned');
        
        st.push(18);
        st.push(17);
        st.push(14);
        
        System.assertEquals(14, st.pop(), 'Wromg element was returned');
        System.assertEquals(18, st.pop(false), 'Wromg element was returned');
        System.assertEquals(17, st.pop(), 'Wromg element was returned');
    }

}