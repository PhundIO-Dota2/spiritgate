#ifndef INCLUDED_flixel_plugin_MouseEventManager
#define INCLUDED_flixel_plugin_MouseEventManager

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifndef INCLUDED_flixel_plugin_FlxPlugin
#include <flixel/plugin/FlxPlugin.h>
#endif
HX_DECLARE_CLASS1(flixel,FlxBasic)
HX_DECLARE_CLASS1(flixel,FlxCamera)
HX_DECLARE_CLASS1(flixel,FlxObject)
HX_DECLARE_CLASS1(flixel,FlxSprite)
HX_DECLARE_CLASS2(flixel,group,FlxGroup)
HX_DECLARE_CLASS2(flixel,group,FlxTypedGroup)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxDestroyable)
HX_DECLARE_CLASS2(flixel,interfaces,IFlxPooled)
HX_DECLARE_CLASS2(flixel,plugin,FlxPlugin)
HX_DECLARE_CLASS2(flixel,plugin,MouseEventManager)
HX_DECLARE_CLASS3(flixel,plugin,_MouseEventManager,ObjectMouseData)
HX_DECLARE_CLASS2(flixel,util,FlxPoint)
namespace flixel{
namespace plugin{


class HXCPP_CLASS_ATTRIBUTES  MouseEventManager_obj : public ::flixel::plugin::FlxPlugin_obj{
	public:
		typedef ::flixel::plugin::FlxPlugin_obj super;
		typedef MouseEventManager_obj OBJ_;
		MouseEventManager_obj();
		Void __construct();

	public:
		inline void *operator new( size_t inSize, bool inContainer=false,const char *inName="flixel.plugin.MouseEventManager")
			{ return hx::Object::operator new(inSize,inContainer,inName); }
		static hx::ObjectPtr< MouseEventManager_obj > __new();
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		//~MouseEventManager_obj();

		HX_DO_RTTI_ALL;
		Dynamic __Field(const ::String &inString, hx::PropertyAccess inCallProp);
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, hx::PropertyAccess inCallProp);
		static bool __SetStatic(const ::String &inString, Dynamic &ioValue, hx::PropertyAccess inCallProp);
		static void __register();
		::String __ToString() const { return HX_HCSTRING("MouseEventManager","\x18","\xcf","\x2e","\x3d"); }

		static Array< ::Dynamic > _registeredObjects;
		static Array< ::Dynamic > _mouseOverObjects;
		static ::flixel::util::FlxPoint _point;
		static Void init( );
		static Dynamic init_dyn();

		static Dynamic add( Dynamic Object,Dynamic OnMouseDown,Dynamic OnMouseUp,Dynamic OnMouseOver,Dynamic OnMouseOut,hx::Null< bool >  MouseChildren,hx::Null< bool >  MouseEnabled,hx::Null< bool >  PixelPerfect);
		static Dynamic add_dyn();

		static Dynamic remove( Dynamic Object);
		static Dynamic remove_dyn();

		static Void reorder( );
		static Dynamic reorder_dyn();

		static Void setMouseDownCallback( Dynamic Object,Dynamic OnMouseDown);
		static Dynamic setMouseDownCallback_dyn();

		static Void setMouseUpCallback( Dynamic Object,Dynamic OnMouseUp);
		static Dynamic setMouseUpCallback_dyn();

		static Void setMouseOverCallback( Dynamic Object,Dynamic OnMouseOver);
		static Dynamic setMouseOverCallback_dyn();

		static Void setMouseOutCallback( Dynamic Object,Dynamic OnMouseOut);
		static Dynamic setMouseOutCallback_dyn();

		static Void setObjectMouseEnabled( Dynamic Object,bool MouseEnabled);
		static Dynamic setObjectMouseEnabled_dyn();

		static bool isObjectMouseEnabled( Dynamic Object);
		static Dynamic isObjectMouseEnabled_dyn();

		static Void setObjectMouseChildren( Dynamic Object,bool MouseChildren);
		static Dynamic setObjectMouseChildren_dyn();

		static bool isObjectMouseChildren( Dynamic Object);
		static Dynamic isObjectMouseChildren_dyn();

		static Void traverseFlxGroup( ::flixel::group::FlxGroup Group,Array< ::Dynamic > OrderedObjects);
		static Dynamic traverseFlxGroup_dyn();

		static ::flixel::plugin::_MouseEventManager::ObjectMouseData getRegister( Dynamic Object,Array< ::Dynamic > Register);
		static Dynamic getRegister_dyn();

		virtual Void destroy( );

		virtual Void update( );

		virtual Void clearRegistry( );
		Dynamic clearRegistry_dyn();

		virtual bool checkOverlap( ::flixel::plugin::_MouseEventManager::ObjectMouseData Register);
		Dynamic checkOverlap_dyn();

		virtual bool checkOverlapWithPoint( ::flixel::plugin::_MouseEventManager::ObjectMouseData Register,::flixel::util::FlxPoint Point,::flixel::FlxCamera Camera);
		Dynamic checkOverlapWithPoint_dyn();

		virtual bool checkPixelPerfectOverlap( ::flixel::util::FlxPoint Point,::flixel::FlxSprite Sprite,::flixel::FlxCamera Camera);
		Dynamic checkPixelPerfectOverlap_dyn();

};

} // end namespace flixel
} // end namespace plugin

#endif /* INCLUDED_flixel_plugin_MouseEventManager */ 
