#ifndef INCLUDED_DraggableWaystone
#define INCLUDED_DraggableWaystone

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
HX_DECLARE_CLASS0(DraggableWaystone)
HX_DECLARE_CLASS0(MainState)
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS2(flixel,group,FlxGroup)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxDestroyable)


class HXCPP_CLASS_ATTRIBUTES  DraggableWaystone_obj : public ::flixel::FlxSprite_obj{
	public:
		typedef ::flixel::FlxSprite_obj super;
		typedef DraggableWaystone_obj OBJ_;
		DraggableWaystone_obj();
		Void __construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name);

	public:
		inline void *operator new( size_t inSize, bool inContainer=true,const char *inName="DraggableWaystone")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< DraggableWaystone_obj > __new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String shape,Array< ::String > stone_properties,::String name);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~DraggableWaystone_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		Dynamic __SetField(const ::String &inString,const Dynamic &inValue, hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_HCSTRING("DraggableWaystone","\xe3","\xc2","\x1e","\x02"); }

		Float originX;
		Float originY;
		::String graphicPath;
		::String shape;
		::MainState state;
		::flixel::FlxSprite standinBlock;
		Array< ::String > stone_properties;
		::String name;
		virtual Void onMouseDown( ::flixel::FlxSprite block);
		Dynamic onMouseDown_dyn();

		virtual Void onMouseUp( ::flixel::FlxSprite block);
		Dynamic onMouseUp_dyn();

};


#endif /* INCLUDED_DraggableWaystone */ 
