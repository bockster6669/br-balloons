# BR-BALLOONS

Thank you for downloading my sciprt!
To setup the br-balloons, you have to put this codes:

# Description:
The script is a representation of real life - you buy balloons, buy a bottle of heaven gas, open the package of balloons, put a balloon on top of the bottle and fill, then breathe. Also the police can check you for using heaven gas

# Preview:
https://www.youtube.com/watch?v=tB49u6gFVIo&t=1s

# Instalation:
For the instalation you have to follow these easy steps:

* qbcore -> shared -> items -> 

```lua

['balloons_packet'] = {['name'] = 'balloons_packet', ['label'] = 'Balloons pack', ['weight'] = 500, ['type'] = 'item', ['image'] = 'ballons_packet.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'Packet with balloons for a birthday'},

['flask'] = {['name'] = 'flask', ['label'] = 'Flask', ['weight'] = 500, ['type'] = 'item', ['image'] = 'flask.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'Flask with heaven gas.'},

['empty_balloon'] = {['name'] = 'empty_balloon', ['label'] = 'Balloons', ['weight'] = 500, ['type'] = 'item', ['image'] = 'empty_balloon.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'Baloons.'},

['full_balloon'] = {['name'] = 'full_balloon', ['label'] = 'Heaven Balloons', ['weight'] = 500, ['type'] = 'item', ['image'] = 'full_balloon.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['description'] = 'Balloon with heaven gas maan.'},
```

* inventory -> html -> js -> around line 500 ->
```js
} else if (itemData.name == "flask") {
                $(".item-info-title").html("<p>" + itemData.label + "</p>");
                $(".item-info-description").html(
                    "<p><strong>Quality: </strong><span>" +
                    itemData.info.quality +
                    "</span></p>"
                );
```
* qb-policejob -> client -> evidence -> Add the following code to the local StatusList {}
```lua
    ["heavengas"] = Lang:t('evidence.heavengas')
```
* qb-policejob -> locales -> en -> Add the following code to evidence {}
```lua
     heavengas = 'it looks like you used heaven gas',
```
