#ifndef INCLUDED_MainState
#define INCLUDED_MainState

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxState
#include <flixel/FlxState.h>
#endif
HX_DECLARE_CLASS0(List)
HX_DECLARE_CLASS0(MainState)
HX_DECLARE_CLASS0(PlacedWaystone)
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS2(flixel,group,FlxGroup)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxDestroyable)
HX_DECLARE_CLASS2(flixel,text,FlxText)


class HXCPP_CLASS_ATTRIBUTES  MainState_obj : public ::flixel::FlxState_obj{
	public:
		typedef ::flixel::FlxState_obj super;
		typedef MainState_obj OBJ_;
		MainState_obj();
		Void __construct(Dynamic MaxSize);

	public:
		inline void *operator new( size_t inSize, bool inContainer=true,const char *inName="MainState")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< MainState_obj > __new(Dynamic MaxSize);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~MainState_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		Dynamic __SetField(const ::String &inString,const Dynamic &inValue, hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_HCSTRING("MainState","\xf8","\x1e","\x82","\x3f"); }

		::String host;
		::flixel::group::FlxGroup z0;
		::flixel::group::FlxGroup z1;
		::flixel::group::FlxGroup z2;
		::flixel::group::FlxGroup z3;
		::flixel::group::FlxGroup z4;
		::flixel::FlxSprite mouse_collider_sprite;
		::flixel::FlxSprite scrollbar_sprite;
		::flixel::text::FlxText stats_text;
		::flixel::FlxSprite sidePanel;
		::List draggableWaystones;
		::List draggableWaystoneTexts;
		virtual Void create( );

		::flixel::FlxSprite sprite_following_mouse;
		virtual Void destroy( );

		int tooltipAppearTimer;
		::flixel::group::FlxGroup tooltip_group;
		virtual Void update( );

		::List waystones;
		virtual Void place( ::PlacedWaystone waystone);
		Dynamic place_dyn();

		virtual bool isValidPlacement( int grid_x,int grid_y,::PlacedWaystone waystone);
		Dynamic isValidPlacement_dyn();

};


#endif /* INCLUDED_MainState */ 
