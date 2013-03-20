# Working goals

## Temporal segmentation

### 14-3-2013 Overleg met Anne.

Uitzoeken naar segmentatietechnieken die puur werken op de data of features uit de data. Inherente eigenschappen waardoor segmenten gemaakt kunnen worden.

Change Point Detection, transities van segmenten. Zijn "gewone" segmenten en "transitie segmenten" te herkennen? PCA-change, variance, FFT, andere features (zonder te classificeren).

Temporal segmentatie met granulariteit instellingen - op minuut / dag / week niveau. Hierarchies door samenvoeging, of ook verschillende cut-points per level? Wat is de output? --> Alleen cutpoints, of waarschijnlijkheid op cut-points? Hierarchies --> op dezelfde plekken of andere plekken bij vergroten schaal?

Filters vs. wrappers. Bij filters zit segmentatie en classificatie apart (?), wrappers zijn gecombineerde methods: In: signaal --> uit: classes. Black box. Moeilijk te vergelijken en fine-tunen. Bij filter beter te vergelijken tussen technieken.

Transities van segmenten (activiteiten): "zitten" --> "staan" ==> "zitten" --> "overgang (opstaan)" --> "staan".

Segmenteren op verschillende dimensies? E.g. "walking" vs "sitting", maar ook "Work" vs "home", "meeting" vs "television/radio".

Wat is precies een transitie? Moment van lage homogeniteit? Kan een algoritme segmenten en transities onderscheiden? Apart segment of een continue punt op de tijdslijn? Clusteren van transities mogelijk? Window-length invloeg op transities? Window-less mogelijk?

Gebruiken van andere segmentatie toepassingen (vision, image) ter inspiratie. Spatio-temporal segmentation (object tracking). K-neighbors?

Transitie stap wordt vaak overgeslagen (wrapper methods) in activiteit herkenning. Dus een toevoeging aan de literatuur.

Vergelijken hoe resultaten gemeten worden. Kwaliteit van segmenten. Hoe in te stellen door user?