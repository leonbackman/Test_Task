public with sharing class ObjectListSorter implements Comparable {
    public Enum SortOrder  { ASCENDING, DESCENDING }
    public Enum FieldType { TYPE_STRING, TYPE_INTEGER, TYPE_DECIMAL }

    private sObject record;
    private object value;
    private String fieldName;
    private SortOrder sortOrderValue;
    private FieldType valueType;
    
    private ObjectListSorter(Object value, SortOrder sortOrderValue, FieldType valueType) {
		this(null, null, sortOrderValue, valueType, value);
    }
    
	private ObjectListSorter(sObject record, String fieldName, SortOrder sortOrderValue, FieldType valueType) {
        this(record, fieldName, sortOrderValue, valueType, null);
    }

    private ObjectListSorter(sObject record, String fieldName, SortOrder sortOrderValue, FieldType valueType, Object value) {
        this.record = record;
        this.sortOrderValue = sortOrderValue;
        this.fieldName = fieldName;
        this.valueType = valueType;
        this.value = value;
    }

    public Integer compareTo(Object objectToCompare) {
        sObject anotherRecord;
        Object sourceValue;
        Object valueToCompare;

        if(this.record != null) {
            sourceValue = record.get(fieldName);
        } else {
            sourceValue = this.value;
        }

        if(((ObjectListSorter) objectToCompare).record != null) {
            valueToCompare = ((ObjectListSorter) objectToCompare).record.get(fieldName);
        } else {
            valueToCompare = ((ObjectListSorter) objectToCompare).value;
        }

        if(valueType.equals(FieldType.TYPE_STRING)) {
            return compareStrings((String) sourceValue, (String) valueToCompare);
        } else if(valueType.equals(FieldType.TYPE_INTEGER)) {
            return compareIntegers((Integer) sourceValue, (Integer) valueToCompare);
        } else if(valueType.equals(FieldType.TYPE_DECIMAL)) {
            return compareDecimals((Decimal) sourceValue, (Decimal) valueToCompare);
        }

        return -1;
    }

    private Integer compareStrings(String sourceValue, String valueToCompare) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < valueToCompare) {
                return -1;
            } else if(sourceValue.equals(valueToCompare)) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < valueToCompare) {
                return 1;
            } else if(sourceValue.equals(valueToCompare)) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    private Integer compareIntegers(Integer sourceValue, Integer valueToCompare) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < valueToCompare) {
                return -1;
            } else if(sourceValue == valueToCompare) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < valueToCompare) {
                return 1;
            } else if(sourceValue == valueToCompare) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    private Integer compareDecimals(Decimal sourceValue, Decimal valueToCompare) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < valueToCompare) {
                return -1;
            } else if(sourceValue == valueToCompare) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < valueToCompare) {
                return 1;
            } else if(sourceValue == valueToCompare) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    public static void standardSort(List<Object> recordList, String fieldName, SortOrder sortOrderValue, FieldType valueType) {
        List<ObjectListSorter> sortResultList = new List<ObjectListSorter>();

        for(Object record : recordList) {
            sortResultList.add(new ObjectListSorter((sObject)record, fieldName, sortOrderValue, valueType));
        }

        sortResultList.sort();
        recordList.clear();

        for(ObjectListSorter sortResult : sortResultList) {
            recordList.add(sortResult.record);
        }
    }
    
	public static void standardSort(List<Object> objList, SortOrder sortOrderValue, FieldType valueType) {
        List<ObjectListSorter> sortResultList = new List<ObjectListSorter>();

        for(Object obj : objList) {
            sortResultList.add(new ObjectListSorter(obj, sortOrderValue, valueType));
        }

        sortResultList.sort();
        objList.clear();

        for(ObjectListSorter sortResult : sortResultList) {
            objList.add(sortResult.value);
        }
    }

    public static void customSort(List<Object> objList, Comparator comparator) {
        for (Integer i = 0; i <  objList.size() - 1; i++) {
          for (Integer j = 0; j <  objList.size() - i - 1; j++) {
            if (comparator.compare(objList[j], objList[j + 1]) > 0) {
              Object temp = objList[j];
              objList[j] = objList[j + 1];
              objList[j + 1] = temp;
            }
          }
        }
      }
    
    public class CompareException extends Exception{}
}