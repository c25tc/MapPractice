//
//  LocationDetailView.swift
//  practice
//
//  Created by Theodore Chan on 1/9/23.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(Color.white)
        .overlay(backButton, alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        .shadow(radius: 10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
                                            center: location.coordinates,
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 10)
                }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    
    }
    
    private var backButton: some View {
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        })
    }
}
