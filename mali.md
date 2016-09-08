# Mali

ARM Mali, ARM's GPU IP.

Beat imagination in 2015: <http://electronics360.globalspec.com/article/5263/arm-overtakes-imagination-in-gpu-shipments>

Bought from FalanX from Norway in 2006: <https://community.arm.com/groups/arm-mali-graphics/blog/2016/06/17/happy-10th-birthday-mali>

FalanX founders:

- https://www.linkedin.com/in/marioblazevic

Product listings:

Hardware using it:

- <https://en.wikipedia.org/wiki/Mali_(GPU)>
- <http://malideveloper.arm.com/resources/development-platforms/>
    - Firefly-RK3288 dev board, 200\$. Specs: <http://malideveloper.arm.com/resources/development-platforms/firefly-rk3288/>
    - Samsung Chromebook
    - Nexus 10
    - Samsung Galaxy S7 in Europe

Jørn Nystad, Mario Blazevic, Edvard Sørgård and Borgar Ljosland are mentioned at http://www.digi.no/artikler/arm-kjoper-norsk-teknologiselskap/280866 They are centered at: NTNU https://en.wikipedia.org/wiki/Norwegian_University_of_Science_and_Technology

Binary driver blobs for free download from <http://malideveloper.arm.com/resources/drivers/> ?

## Open source

-   the kernel side source or part of it was released under the GPL:
    - http://malideveloper.arm.com/resources/drivers/open-source-mali-utgard-gpu-linux-kernel-drivers/
    - http://malideveloper.arm.com/resources/previous-releases/open-source-mali-gpus-linux-kernel-device-drivers-previous-releases/
-   Phoronix says the driver cannot be accepted into the kernel mainline without an open userspace to support it, as it cannot be used directly without that: https://www.phoronix.com/scan.php?page=news_item&px=MTY3OTM
-   the userland part of the driver is available only as binary blobs at: http://malideveloper.arm.com/resources/drivers/arm-mali-midgard-gpu-user-space-drivers/
-   examples on the SDK: <http://malideveloper.arm.com/resources/sdks/opengl-es-sdk-for-linux/> Also has emulator libraries to run without the GPU. TODO: emulator means software renderer? Possibly it is: <http://malideveloper.arm.com/resources/tools/opengl-es-emulator/> which implements OpenGL ES with OpenGL.

## Mali money making

- <http://www.arm.com/about/newsroom/24357.php>: 2009, 18
- <http://www.anandtech.com/show/7112/the-arm-diaries-part-1-how-arms-business-model-works/2>: adds 0.75% - 1.25% royalties
