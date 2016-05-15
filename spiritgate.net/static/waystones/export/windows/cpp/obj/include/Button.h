#ifndef INCLUDED_Button
#define INCLUDED_Button

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_FlxSprite
#include <flixel/FlxSprite.h>
#endif
HX_DECLARE_CLASS0(Button)
HX_DECLARE_CLASS0(MainState)
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS1(flixel,FlxState)
HX_DECLARE_CLASS2(flixel,group,FlxGroup)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxDestroyable)


class HXCPP_CLASS_ATTRIBUTES  Button_obj : public ::flixel::FlxSprite_obj{
	public:
		typedef ::flixel::FlxSprite_obj super;
		typedef Button_obj OBJ_;
		Button_obj();
		Void __construct(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String text,Dynamic onClick);

	public:
		inline void *operator new( size_t inSize, bool inContainer=true,const char *inName="Button")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< Button_obj > __new(hx::Null< Float >  __o_X,hx::Null< Float >  __o_Y,::MainState state,::String text,Dynamic onClick);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~Button_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		Dynamic __SetField(const ::String &inString,const Dynamic &inValue, hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		::String __ToString() const { return HX_HCSTRING("Button","\x12","\xd6","\x74","\x0e"); }

		::MainState state;
		Dynamic onClick;
		Dynamic &onClick_dyn() { return onClick;}
		int onClickCooldown;
		virtual Void update( );

};


#endif /* INCLUDED_Button */ 
