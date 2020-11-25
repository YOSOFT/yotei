# Yotei (よてい)
Your personal notes, target and achievements with Kanban style.  
Built using flutter, moor, boardview, etc.  
(よていはかんばんスタイルのあなたの個人的なメモです) 

## Get this app on Playstore
[Download the app here](https://play.google.com/store/apps/details?id=com.ydhnwb.laplanche)

## Screenshots
![](https://github.com/ydhnwb/yotei/blob/master/screenshots/1.jpg)    ![](https://github.com/ydhnwb/yotei/blob/master/screenshots/2.jpg)  
![](https://github.com/ydhnwb/yotei/blob/master/screenshots/3.jpg)    ![](https://github.com/ydhnwb/yotei/blob/master/screenshots/4.jpg)  
![](https://github.com/ydhnwb/yotei/blob/master/screenshots/5.jpg)    ![](https://github.com/ydhnwb/yotei/blob/master/screenshots/6.jpg)  


## Demo
[![Demo project](https://img.youtube.com/vi/TSB7Va9jxxg/0.jpg)](https://www.youtube.com/watch?v=TSB7Va9jxxg)


### Technical Things

Here is the thing, I'm using flutter board\_view that you can find [here](https://pub.dev/packages/boardview). But I'm not exactly using their interface for onDragList and onDropItem \(I mean, I'm using it but handle it differently\).

Here is my table looks like \(maybe a little bit different but this is a big picture of it\):

\*\*\*\*

| Board | Category | Panel | Panel Item |
| :--- | :--- | :--- | :--- |
| id | id | id | id |
| title | name | name | name |
| description |  | description | description |
| category\_id |  | order | order |
| last\_updated |  | board\_id | panel\_id |

### What happen when I created a new board?

1. Before the board get created, I check the category first, like below: `select * from category where name = "your category name"`
2. If the particular category with given name is already exists, then return id of the category.
3. Board instance assign the returning id to the category\_id. Example: Board\(null, "My board", "My desc", returnedIdCategory, Date.now\(\)\)
4. If the particular category name doesnt exists, then insert a new record to table then return the id and do the same



### What happen when I created a new Panel/Item?

1. Let assume you are inserting a first fresh panel.
2. Before inserting to database, I check it first: `select * from panel where board_id = givenBoardId`
3. If the return is empty \(means there is no panel with particualr board\_id, set the Panel order to = 1
4. Insert new record to db
5. If panel are already exists, then get order it by "order" key, and get the last value, then increment the order like order+1
6. **Its same with panel item, the only different is board\_id and panel\_id**



### What happens when I reordering panel/item?

1. For example you get a panel like this below: **\#Panel 1           Panel 2        Panel 3 Item A               Item B           Item c**
2. Example you are moving the **Panel 1 to Panel 2,** then the order should be like this: **Panel 2, Panel 1, Panel 3**
3. When you are moving a panel or panel item, you are rearranging the  list. With above case should look like this in short: `var panels = [Panel 1, Panel 2, Panel 3] var oldPanel = panels[0] panels.remove(0) panels.insert(1, oldPanel) // 0 and 1 is retrieved from onDropList`  
4. So you will get like \[Panel 2, Panel 1, Panel 3\]
5. But, the panel order is not updated, the panel.order still look like this \[Order 2, Order 1, Order 3\]
6. To update the order you need to for loop each panels and update the order with the correct index: \(it is a big picture of the code, not the actual code\):  `for \(int i = 0; i &lt; panelDatas.length; i++\) {       panelDatas\[i\] = panelDatas\[i\].copyWith\(order: i\);       await \_appDb.panelDao.updatePanelPosition\(panelDatas\[i\]\);     }`
7. It is also used for panel item
8. Also used for deleting 

## Apache 2.0 License
