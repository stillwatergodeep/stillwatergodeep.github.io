when use Interface or Abstract class

Abstract classes are similar to interfaces. You cannot instantiate them, and they may contain a mix of methods declared with or without an implementation. However, with abstract classes, you can declare fields that are not static and final, and define public, protected, and private concrete methods. With interfaces, all fields are automatically public, static, and final, and all methods that you declare or define (as default methods) are public. In addition, you can extend only one class, whether or not it is abstract, whereas you can implement any number of interfaces.

Which should you use, abstract classes or interfaces?

Consider using abstract classes if any of these statements apply to your situation:
You want to share code among several closely related classes.
You expect that classes that extend your abstract class have many common methods or fields, or require access modifiers other than public (such as protected and private).
You want to declare non-static or non-final fields. This enables you to define methods that can access and modify the state of the object to which they belong.
Consider using interfaces if any of these statements apply to your situation:
You expect that unrelated classes would implement your interface. For example, the interfaces Comparable and Cloneable are implemented by many unrelated classes.
You want to specify the behavior of a particular data type, but not concerned about who implements its behavior.
You want to take advantage of multiple inheritance of type.

An example of an abstract class in the JDK is AbstractMap, which is part of the Collections Framework. Its subclasses (which include HashMap, TreeMap, and ConcurrentHashMap) share many methods (including get, put, isEmpty, containsKey, and containsValue) that AbstractMap defines.

An example of a class in the JDK that implements several interfaces is HashMap, which implements the interfaces Serializable, Cloneable, and Map<K, V>. By reading this list of interfaces, you can infer that an instance of HashMap (regardless of the developer or company who implemented the class) can be cloned, is serializable (which means that it can be converted into a byte stream; see the section Serializable Objects), and has the functionality of a map. In addition, the Map<K, V> interface has been enhanced with many default methods such as merge and forEach that older classes that have implemented this interface do not have to define.

Note that many software libraries use both abstract classes and interfaces; the HashMap class implements several interfaces and also extends the abstract class AbstractMap.

Abstract classes have the advantage of allowing better forward compatibility.  Once clients use an interface, you cannot change it; if they use an abstract class, you can still add behavior without breaking existing code. If compatibility is a concern, consider using abstract classes.
Even if you do have default implementations or internal state, consider offering an interface and an abstract implementation of it. This will assist clients, but still allow them greater freedom if desired [1].

原则1：现实世界的对象都是具有状态和行为的，这种类在设计时应该抽象成抽象类，类有一些拓展的行为时，应该使用接口
原则2:   接口提供一些稳定不变的抽象的行为（所有类都具有的行为），抽象类在实现接口的基础上，提供一些共有的状态或行为（很多类具有的状态或行为）

referenece
https://www.quora.com/In-Java-when-should-you-use-an-interface-instead-of-an-abstract-class
https://docs.oracle.com/javase/tutorial/java/IandI/abstract.html