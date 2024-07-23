import geopandas as gpd
from shapely.geometry import Polygon
import folium


from src.neighbourhood_boundary_load_prototype.south_middleton_boundary \
    import boundary

long_lat_list = ([[coordinate["longitude"],coordinate["latitude"]] 
                  for coordinate in boundary])

neighbourhood_boundary_geometry = Polygon(long_lat_list)
neighbourhood_boundary = (gpd.GeoDataFrame(index=[0], crs='epsg:4326', 
                            geometry=[neighbourhood_boundary_geometry]))


neighbourhood_boundary["neighbourhood"] = "PC07"
neighbourhood_boundary["boundary"] = neighbourhood_boundary.boundary

print(neighbourhood_boundary.head())

map = folium.Map(location=[53.545, -2.21], zoom_start=15, tiles="OpenStreetMap")

for _, r in neighbourhood_boundary.iterrows():
    sim_geo = gpd.GeoSeries(neighbourhood_boundary["geometry"]).simplify(tolerance=0.001)
    geo_json = sim_geo.to_json()
    geo_json = folium.GeoJson(data=geo_json, style_function=lambda x: {"fillColor": "brown"})
    folium.Popup("South Middleton").add_to(geo_json)
    geo_json.add_to(map)

map.show_in_browser()
