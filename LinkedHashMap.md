##                                                           LinkedHashMap的源码解读

LinkedHashMap 数据结构

    static class Entry<K,V> extends HashMap.Node<K,V> {
            Entry<K,V> before, after;
            Entry(int hash, K key, V value, Node<K,V> next) {
                super(hash, key, value, next);
            }
        }

可见entry在node的基础上增加了前后向指针，其实是一个双向链表doubly link list
Node的结构

    static class Node<K,V> implements Map.Entry<K,V> {
            final int hash;
            final K key;
            V value;
            Node<K,V> next;

        Node(int hash, K key, V value, Node<K,V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
            //some method omitted
        }

构造方法以及元素增删操作都是调用父类的方法
不同于HashMap的是

1. 在增加节点的时候newNode的实现方式不同（在JDK1.8中，可能调用的是newTreeNode，此处略去）

HashMap

     Node<K,V> newNode(int hash, K key, V value, Node<K,V> next) {
            return new Node<>(hash, key, value, next);
        }

LinkedHashMap

    Node<K,V> newNode(int hash, K key, V value, Node<K,V> e) {
            LinkedHashMap.Entry<K,V> p =
                new LinkedHashMap.Entry<K,V>(hash, key, value, e);//Entry 其实调用的就是父类Node的构造方法
            linkNodeLast(p);
            return p;
        }
    // link at the end of list
        private void linkNodeLast(LinkedHashMap.Entry<K,V> p) {
            LinkedHashMap.Entry<K,V> last = tail;
            tail = p;
            if (last == null)
                head = p;
            else {
                p.before = last;
                last.after = p;
            }
        }

​linkNodeLast方法在链表为空时tail＝p，head＝p，即新增的第一个节点同时为头和尾
​当链表不为空时，新增节点为尾节点，tail＝p，同时与之前的最后一个节点相互连接，p.before=last;last.after=p;
​通过以上操作，保证了增加的节点按照增加的顺序链接起来。

1. HashMap 中定义三个函数，在LinkedHashMap中去实现，并在hashMap中回调

HashMap

    // Callbacks to allow LinkedHashMap post-actions
        void afterNodeAccess(Node<K,V> p) { }
        void afterNodeInsertion(boolean evict) { }
        void afterNodeRemoval(Node<K,V> p) { }

LinkedHashMap中对afterNodeAccess的实现
当访问了链表中的某个节点之后，将该节点移动到链表的最后，即成为最新的节点。

    void afterNodeAccess(Node<K,V> e) { // move node to last
            LinkedHashMap.Entry<K,V> last;
            if (accessOrder && (last = tail) != e) {
                LinkedHashMap.Entry<K,V> p =
                    (LinkedHashMap.Entry<K,V>)e, b = p.before, a = p.after;
                p.after = null;
                if (b == null)
                    head = a;
                else
                    b.after = a;
                if (a != null)
                    a.before = b;
                else
                    last = b;
                if (last == null)
                    head = p;
                else {
                    p.before = last;
                    last.after = p;
                }
                tail = p;
                ++modCount;
            }
        }

afterNodeInsertion是当新增一个节点之后，将最老的节点删除，有点LRU的味道。

    void afterNodeInsertion(boolean evict) { // possibly remove eldest
            LinkedHashMap.Entry<K,V> first;
            if (evict && (first = head) != null && removeEldestEntry(first)) {
                K key = first.key;
                removeNode(hash(key), key, null, false, true);
            }
        }
 
afterNodeRemoval从双向链表中删除一个节点
       
     void afterNodeRemoval(Node<K,V> e) { // unlink
            LinkedHashMap.Entry<K,V> p =
                (LinkedHashMap.Entry<K,V>)e, b = p.before, a = p.after;
            p.before = p.after = null;
            if (b == null)
                head = a;
            else
                b.after = a;
            if (a == null)
                tail = b;
            else
                a.before = b;
        }

感觉这里删除和插入有点不一样，插入是在插入的同时，即构造节点的时候，调用newNode方法的时候插入双向链表，而不是在afterNodeInsertion时候插入双向链表。而删除确是在删除之后afterNodeRemoval从双向链表中删除，而不是在remove方法时候删除。