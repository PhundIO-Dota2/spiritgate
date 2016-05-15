#ifndef INCLUDED_PlacedWaystone
#define INCLUDED_PlacedWaystone

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
HX_DECLARE_CLASS0(MainState)
HX_DECLARE_CLASS0(PlacedWaystone)
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS2(flixel,group,FlxGroup)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxDestroyable)


class HXCPP_CLASS_ATTRIBUTES  PlacedWaystone_obj : public ::flixel::FlxSprite_obj{
	public:
		typedef ::flixel::FlxSprite_obj super;
		typedef PlacedWaystone_obj OBJ_;
		PlacedWaystone_obj();
		Void __construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name);

	public:
		inline void *operator new( size_t inSize, bool inContainer=true,const char *inName="PlacedWaystone")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< PlacedWaystone_obj > __new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~PlacedWaystone_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		Dynamic __SetField(const ::String &inString,const Dynamic &inValue, hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_HCSTRING("PlacedWaystone","\xd3","\xd3","\xa4","\x5d"); }

		::MainState state;
		Array< ::String > stone_properties;
		::String name;
		::String shape;
		virtual Void onMouseDown( ::PlacedWaystone block);
		Dynamic onMouseDown_dyn();

		virtual Void onMouseUp( ::PlacedWaystone block);
		Dynamic onMouseUp_dyn();

};


#endif /* INCLUDED_PlacedWaystone */ 
