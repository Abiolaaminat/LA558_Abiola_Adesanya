var wms_layers = [];

var format_Counties_0 = new ol.format.GeoJSON();
var features_Counties_0 = format_Counties_0.readFeatures(json_Counties_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Counties_0 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Counties_0.addFeatures(features_Counties_0);
var lyr_Counties_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Counties_0, 
                style: style_Counties_0,
                interactive: true,
    title: 'Counties<br />\
    <img src="styles/legend/Counties_0_0.png" /> 3641 - 102282<br />\
    <img src="styles/legend/Counties_0_1.png" /> 102282 - 200922<br />\
    <img src="styles/legend/Counties_0_2.png" /> 200922 - 299563<br />\
    <img src="styles/legend/Counties_0_3.png" /> 299563 - 398203<br />\
    <img src="styles/legend/Counties_0_4.png" /> 398203 - 496844<br />'
        });
var format_city_d2020_1 = new ol.format.GeoJSON();
var features_city_d2020_1 = format_city_d2020_1.readFeatures(json_city_d2020_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_city_d2020_1 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_city_d2020_1.addFeatures(features_city_d2020_1);
var lyr_city_d2020_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_city_d2020_1, 
                style: style_city_d2020_1,
                interactive: false,
                title: '<img src="styles/legend/city_d2020_1.png" /> city_d2020'
            });

lyr_Counties_0.setVisible(true);lyr_city_d2020_1.setVisible(true);
var layersList = [lyr_Counties_0,lyr_city_d2020_1];
lyr_Counties_0.set('fieldAliases', {'AREA': 'AREA', 'PERIMETER': 'PERIMETER', 'COUNTY_': 'COUNTY_', 'COUNTY_ID': 'COUNTY_ID', 'CO_NUMBER': 'CO_NUMBER', 'CO_FIPS': 'CO_FIPS', 'ACRES_SF': 'ACRES_SF', 'ACRES': 'ACRES', 'FIPS': 'FIPS', 'COUNTY': 'COUNTY', 'ST': 'ST', 'OID_': 'OID_', 'ID': 'ID', 'COUNTY_1': 'COUNTY_1', 'TOT_POP': 'TOT_POP', 'TOT_POP_UR': 'TOT_POP_UR', 'TOT_POP_RU': 'TOT_POP_RU', 'URBAN': 'URBAN', 'Rural': 'Rural', 'FIPS_no': 'FIPS_no', 'Pop_num': 'Pop_num', 'county_pop_County': 'county_pop_County', 'county_pop_Year': 'county_pop_Year', 'county_pop_Population': 'county_pop_Population', });
lyr_city_d2020_1.set('fieldAliases', {'GEOID': 'GEOID', 'NAME': 'NAME', 'popOver18': 'popOver18', 'totalPop': 'totalPop', 'per18o': 'per18o', 'per75und18': 'per75und18', });
lyr_Counties_0.set('fieldImages', {'AREA': 'TextEdit', 'PERIMETER': 'TextEdit', 'COUNTY_': 'TextEdit', 'COUNTY_ID': 'TextEdit', 'CO_NUMBER': 'TextEdit', 'CO_FIPS': 'Range', 'ACRES_SF': 'TextEdit', 'ACRES': 'TextEdit', 'FIPS': 'TextEdit', 'COUNTY': 'TextEdit', 'ST': 'TextEdit', 'OID_': 'Range', 'ID': 'TextEdit', 'COUNTY_1': 'TextEdit', 'TOT_POP': 'TextEdit', 'TOT_POP_UR': 'TextEdit', 'TOT_POP_RU': 'TextEdit', 'URBAN': 'Range', 'Rural': 'Range', 'FIPS_no': 'Range', 'Pop_num': 'Range', 'county_pop_County': 'TextEdit', 'county_pop_Year': 'TextEdit', 'county_pop_Population': 'TextEdit', });
lyr_city_d2020_1.set('fieldImages', {'GEOID': 'TextEdit', 'NAME': 'TextEdit', 'popOver18': 'TextEdit', 'totalPop': 'TextEdit', 'per18o': 'TextEdit', 'per75und18': 'TextEdit', });
lyr_Counties_0.set('fieldLabels', {'AREA': 'inline label', 'PERIMETER': 'inline label', 'COUNTY_': 'inline label', 'COUNTY_ID': 'inline label', 'CO_NUMBER': 'inline label', 'CO_FIPS': 'inline label', 'ACRES_SF': 'inline label', 'ACRES': 'inline label', 'FIPS': 'inline label', 'COUNTY': 'header label', 'ST': 'inline label', 'OID_': 'inline label', 'ID': 'inline label', 'COUNTY_1': 'inline label', 'TOT_POP': 'inline label', 'TOT_POP_UR': 'inline label', 'TOT_POP_RU': 'inline label', 'URBAN': 'inline label', 'Rural': 'inline label', 'FIPS_no': 'inline label', 'Pop_num': 'inline label', 'county_pop_County': 'inline label', 'county_pop_Year': 'inline label', 'county_pop_Population': 'inline label', });
lyr_city_d2020_1.set('fieldLabels', {'GEOID': 'no label', 'NAME': 'no label', 'popOver18': 'no label', 'totalPop': 'no label', 'per18o': 'no label', 'per75und18': 'no label', });
lyr_city_d2020_1.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});