public class Stack {
    @testVisible private List<Object> objList;
    private List<Object> orderedList;
    private Boolean isOrdered = false;
    private Comparator comparator;
    private String fieldName;
    private ObjectListSorter.SortOrder sortOrderValue;
    private ObjectListSorter.FieldType fieldType;

    public Stack() {
        this(null, null, null, null, null);
    }

    public Stack(Comparator comparator) {
        this(null, comparator, null, null, null);
    }
    
	public Stack(List<sObject> objList, Comparator comparator) {
        this(objList, comparator, null, null, null);
    }

    public Stack(ObjectListSorter.SortOrder sortOrderValue, ObjectListSorter.FieldType fieldType) {
        this(null, null, null, sortOrderValue, fieldType);
    }
    
    public Stack(List<Object> objList, ObjectListSorter.SortOrder sortOrderValue, ObjectListSorter.FieldType fieldType) {
        this(objList, null, null, sortOrderValue, fieldType);
    }
    
	public Stack(String fieldName, ObjectListSorter.SortOrder sortOrderValue, ObjectListSorter.FieldType fieldType) {
        this(null, null, fieldName, sortOrderValue, fieldType);
    }
    
    public Stack(List<sObject> objList, String fieldName, ObjectListSorter.SortOrder sortOrderValue, ObjectListSorter.FieldType fieldType) {
        this(objList, null, fieldName, sortOrderValue, fieldType);
    }

    public Stack(List<Object> objList, Comparator comparator, String fieldName, ObjectListSorter.SortOrder sortOrderValue, ObjectListSorter.FieldType fieldType ) {
        this.objList = objList != null ? objList : new List<Object>();
        this.comparator = comparator;
        this.fieldName = fieldName;
        this.sortOrderValue = sortOrderValue;
        this.fieldType = fieldType;
        this.orderedList = new List<Object>();
    }
    
    public Integer size() {
        return this.objList.size();
    }

    public Boolean isEmpty() {
        return size() == 0;
    }

    public void push(Object itemToPush) {
        this.push(itemToPush, true);
    }
        
    public void push(Object itemToPush, Boolean isQuick) {
        this.objList.add(itemToPush);
        this.isOrdered = false;
        
        if(!isQuick) {
			sort();
        }
        
    }
    
    public Object pop() {
        return this.pop(true);
    }
    
    public Object pop(Boolean isQuick) {
        if (isEmpty()) {
            throw new StackUnderflowException();
        }
        
        Object objtoPop;
        
        if(this.isOrdered) {
            objtoPop = this.orderedList.remove(this.orderedList.size() - 1);
            this.objList.clear();
            this.objList.addAll(orderedList);
        } else if(!isQuick) {
            sort();
            if(!this.orderedList.isEmpty()) {
                objtoPop = this.orderedList.remove(this.orderedList.size() - 1);
                this.objList.clear();
                this.objList.addAll(orderedList);
            } else {
                objtoPop = this.objList.remove(size() - 1);
            }
        } else {
            objtoPop = this.objList.remove(size() - 1);
            this.isOrdered = false;
        }
        
        return objtoPop;
    }
    
    private void sort() {
        if(this.comparator != null){
            this.orderedList.clear();
            this.orderedList.addall(this.objList);
            
            ObjectListSorter.customSort(this.orderedList, this.comparator);
            this.isOrdered = true;
            this.objList.clear();
            this.objList.addAll(this.orderedList);
        } else if(sortOrderValue != null && this.fieldType != null && !(this.objList[0] instanceof sObject)) {
            this.orderedList.clear();
            this.orderedList.addall(this.objList);
            
            ObjectListSorter.standardSort(this.orderedList, this.sortOrderValue, this.fieldType);
            this.isOrdered = true;
            this.objList.clear();
            this.objList.addAll(this.orderedList);
        } else if((this.objList[0] instanceof sObject) && this.fieldName != null && this.sortOrderValue != null && this.fieldType != null ) {
            this.orderedList.clear();
            this.orderedList.addall(this.objList);
            
            ObjectListSorter.standardSort(this.orderedList, this.fieldName, this.sortOrderValue, this.fieldType);
            this.isOrdered = true;
            this.objList.clear();
            this.objList.addAll(this.orderedList);
        }
    }

	public class StackUnderflowException extends Exception {}
}